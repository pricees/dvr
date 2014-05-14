require "singleton"
require "observer"

module Dvr
  class Scheduler
    include Singleton

    MIN = 60
    #
    # Input Parser
    #
    # Expecting array of hashes
    #   :start_time - When to start recording
    #   :end_time - when to end recording
    #   :channel  - channel to record
    #   :priority - (def. to 1)
    # 
    attr_accessor :user_schedule
    
    def schedule
      @schedule ||= Set.new
    end

    def register_device(device)
      @device = device
    end

    def channels_for_time(time = Time.now)
      user_schedule.inject([]) do |channels, schedule|
        if time.between?(schedule[:start_time], schedule[:end_time])
          channels << schedule[:channel]
        end
        channels
      end
    end

    #
    # This method steps from the users day to build recording schedules
    #
    def update_recording_schedule(time)
      
      start_recording, stop_recording = user_schedule_range_from(time)

      times = Array.new(device.tuners, start_recording) # Assume recording on multiple threads possible

      # 2 N*M complexity 
      while times.any? { |t| t < stop_recording } do
        times.dup.each.with_index do |time, i| 
          next if time > stop_recording
          #
          # Grab channels that we hope to record
          #
          channels = channels_for_time(time)
          show_added = false

          channels.each do |channel|
            break if show_added

            show = TvSchedule.instance.next_show(channel, time)

            if show && !schedule.include?(show)
              puts "#{i}: #{show.inspect}"
              show_added = true
              schedule << show
              times[i] += show[:running_length]
            end

          end
          show_added || (times[i] += MIN)
        end
      end

    end

    def recordables
      schedule.inject([]) do |recordables, show| 
        r = Recording.new(show)
        recordables.push r if r.recordable?
        recordables
      end 
    end

    def run!
      t = Thread.new do
        loop do
          ct = Time.now

          update_recording_schedule(ct)

          device.update(recordables)

          # Calculate the time till the next minute
          next_min = Time.new(ct.year, ct.month, ct.day, ct.hour, ct.min + 1) - ct
          p ct, next_min
          sleep next_min
        end
      end
    end

    private

    attr_reader :device

    #
    # The time a user starts the schedule and ends schedule
    #
    def user_schedule_range_from(time)
      _start_time = nil
      _end_time = nil
      user_schedule.each do |s|
        if _start_time.nil? || _start_time > s[:start_time]
          _start_time = s[:start_time]
        end

        if _end_time.nil? || _end_time < s[:end_time]
          _end_time = s[:end_time]
        end
      end
      [ _start_time, _end_time ]
    end
  end
end
