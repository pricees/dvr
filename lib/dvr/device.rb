module Dvr
  class Device
    attr_reader :tuners
    attr_reader :total_space
    attr_accessor :recordings
    attr_reader :current_recordings

    def initialize(tuners = 2, total_space = 200E9)
      @tuners             = tuners
      @current_recordings = []
      @total_space        = total_space
      @recordings         = []
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
      tuners.times do |n|
        return n if current_recordings[n].nil?
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
  end
end
