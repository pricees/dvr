module Dvr
  class Recording

    DISK = { sd: 720, hd: 3600, }

    attr_accessor :recording

    def initialize(show)
      @show = show
    end

    #
    # NOTE: Allow recording up to arbitrary seconds before show starts
    #
    def recordable?
      (Time.now + recording_start_time_delta > start_time) && \
        Time.now < end_time
    end

    def recording_start_time_delta 
      @recording_start_time_delta ||= 60
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

    def record!
      @recording = true
      # TODO: implement how to record
    end

    def halt!
      @recording = false
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
