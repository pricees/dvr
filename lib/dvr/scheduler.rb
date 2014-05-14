require "singleton"
require "observer"

module Dvr
  class Scheduler
    include Singleton
    include Observable

    def run!
      t = Thread.new do
        loop do
          ct = Time.now

          notify_observers

          # Calculate the time till the next minute
          next_min = Time.new(ct.year, ct.month, ct.day, ct.hour, ct.min + 1) - ct
          p ct, next_min
          sleep next_min
        end
      end
    end

  end
end
