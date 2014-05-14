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

    def file
      # TODO: Where the file is stored
    end

    def file_size
      # TODO: File size
    end

    def full_size
      DISK[resolution] * (running_length / 30)
    end

  end
end
