module Dvr
  class Device

    def initialize(streams = 1, total_space = 200E9)
      @streams = streams
      @total_space = total_space
      @recordings = []
    end

    attr_reader :streams
    attr_reader :total_space
    attr_accessor :recordings

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
