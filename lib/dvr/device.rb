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

    #
    # NOTE: This makes approximations based on the FULL recording size of shows. Partial recordings will be approximated with there full size
    def space_remaining
      recordings_size = 0
      if recordings.any?
        recordings_size =  recordings.map(&:approximate_space).reduce(:+) 
      end

      total_space - recordings_size
    end

    def space_remaining?
      space_remaining > 0
    end
  end
end
