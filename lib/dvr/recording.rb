module Dvr
  class Recording

    DISK = { sd: 720, hd: 3600, }

    attr_accessor :recording

    def initialize(show)
      @show = show
    end

    def running?
      Time.now < end_time
    end

    def end_time
      start_time + running_length
    end

    def start_time
      @show[:start_time]
    end

    def running_length
      @show[:running_length]
    end

    def priority
      @show[:priority] || 1
    end

    def recording?
      !!@recording
    end

    def resolution
      @show[:resolution] || :sd
    end

    def approximate_space
      DISK[resolution] * (running_length / 30)
    end
  end
end
