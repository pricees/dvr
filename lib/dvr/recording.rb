module Dvr
  class Recording

    def initialize(show)
      @show = show
    end

    def running?
      Time.now < end_time
    end

    def end_time
      @show[:start_time] + @show[:running_length]
    end
  end
end
