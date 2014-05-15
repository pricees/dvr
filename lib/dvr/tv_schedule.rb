require "singleton"

module Dvr
  class TvSchedule
    include Singleton

    #
    # Shows is a hash of hashs
    # The parent hash keys are channels
    #   The channels sub hash keys are show start times
    #   The channels sub hash values are the shows
    #
    attr_accessor :showtimes


    #
    # Espects shows ordered by start_time
    #
    def showtimes=(shows)
      tmp = Hash.new { |h, k| h[k] = {} }
      shows.each do |show|
        tmp[show[:channel]].merge!(show[:start_time] => show)
      end
      @showtimes = tmp
    end

    def showtimes
      @showtimes ||= Hash.new { |h, k| h[k] = {} }
    end

    def next_show(channel, time = Time.now, end_time = Time.now)

      shows = showtimes[channel.to_i]
      return if shows.nil? || shows.none?

      _show = shows.detect { |show| time <= show[0] && show[0] <= end_time  }
      _show && _show[1]
    end
  end
end
