module Dvr
  class Recording

    attr_accessor :recording

    def initialize(show)
      @show = show
    end

    def running?
      Time.now < end_time
    end

    def end_time
      @show[:start_time] + @show[:running_length]
    end

    def priority
      @show[:priority] || 1
    end

    def recording?
      !!@recording
    end
  end
end
