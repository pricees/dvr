module Dvr
  class Device
    attr_reader :tuners
    attr_reader :total_space
    attr_accessor :recordings
    attr_reader :current_recordings

    def initialize(tuners = 2, total_space = 200E9, scheduler = Scheduler.instance)
      @tuners             = tuners
      @current_recordings = []
      @total_space        = total_space
      @recordings         = []
      @scheduler          = scheduler
      
      @scheduler.add_observer(self)
    end

    def play(i)
      Play.do(recordings[i])
    end

    #
    # Returns false if no avaiable tuners
    # Returns tuner number if recordable
    #
    def record(recording)
      if recordable?(recording)
        tuner = open_tuner
        current_recordings[tuner] = recording
        current_recordings[tuner].record!

        tuner
      else
        false 
      end
    end

    #
    # Are there any tuners that aren't recording?
    # Can the full size of the recording fit?
    #
    def recordable?(recording)
      !!open_tuner && (recording.full_size < space_available)
    end

    #
    # Returns the index of the open tuner
    # TODO: Refactor into Tuner object
    #
    def open_tuner
      tuners.times do |tuner|
        return tuner if current_recordings[tuner].nil?
      end

      nil
    end

    #
    # NOTE: This makes approximations based on the FULL recording size of
    # shows. Again, partial recordings will be approximated with there full
    # size. The reason for this is because we will want to capture the entire
    # show in subsequent recording attempts. We want that space to be reserved
    def space_available
      used = 0
      if recordings.any?
        used = recordings.map(&:full_size).reduce(:+) 
      end

      total_space - used
    end

    def space_available?
      space_available > 0
    end

    #
    # Update receives new recordings
    # It checks to see current recordings and free those up
    # After, it attempts to start recording the array passed
    #
    def update(new_recordings = [])
      new_recordings ||= [] # if nil is passed

      check_recordings
      new_recordings.each { |recording| record recording }
    end

    private 

    def free_up_tuner(tuner)
      current_recordings[tuner] = nil
    end

    def stop_and_store_recording(recording)
      recording.stop_recording
      recordings.unshift recording
    end

    #
    # TODO: Check if current recording is lower priority than new request
    #
    def check_recordings
      tuners.times do |tuner|
        recording = current_recordings[tuner]

        next if recording.nil? || recording.recordable?

        stop_and_store_recording(recording)
        free_up_tuner(tuner)
      end
    end
  end
end
