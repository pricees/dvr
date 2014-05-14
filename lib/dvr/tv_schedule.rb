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
    attr_reader :showtimes

    def update_schedule(time = Time.now)
      # TODO: Pull new data for shows and times
      schedule(time)
    end

    #
    #
    #
    def schedule(time)
      time = Time.now if time < Time.now
    end


    def next_show(channel, time = Time.now)
      update_schedule(time)
      
      shows = showtimes[channel]

      return if shows.nil? || shows.none?

      shows.first[1]
    end
  end
end
