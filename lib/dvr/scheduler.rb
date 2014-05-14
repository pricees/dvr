require "singleton"
require "observer"

module Dvr
  class Scheduler
    include Singleton
    include Observable

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
      @schedule ||= []
    end

    def channels_for_time(time = Time.now)
      user_schedule.inject([]) do |channels, schedule|
        if time.between?(schedule[:start_time], schedule[:end_time])
          p schedule
          channels << schedule[:channel]
        end
        channels
      end
    end

    def update_recording_schedule(time)
    end

    def run!
      t = Thread.new do
        loop do
          ct = Time.now

          update_schedule

          notify_observers

          # Calculate the time till the next minute
          next_min = Time.new(ct.year, ct.month, ct.day, ct.hour, ct.min + 1) - ct
          p ct, next_min
          sleep next_min
        end
      end
    end

  end
end
