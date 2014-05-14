module Dvr
  class Device
    attr_reader :tuners
    attr_reader :total_space
    attr_accessor :recordings

    def initialize(tuners = 2, total_space = 200E9)
      @tuners             = tuners
      @current_recordings = []
      @total_space        = total_space
      @recordings         = []
    end

    def current_recording
      @current_reordings
    end

    def play(i)
      Play.do(recordings[i])
    end

    #
    # NOTE: This makes approximations based on the FULL recording size of
    # shows. Again, partial recordings will be approximated with there full
    # size. The reason for this is because we will want to capture the entire
    # show in subsequent recording attempts. We want that space to be reserved
    def space_remaining
      used = 0
      if recordings.any?
        used = recordings.map(&:full_size).reduce(:+) 
      end

      total_space - used
    end

    def space_remaining?
      space_remaining > 0
    end
  end
end
