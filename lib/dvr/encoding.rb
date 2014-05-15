module Dvr
  class Encoding
    def self.output(schedule)
      schedule.map do |show|
        start_time = show[:start_time]

        [ start_time.strftime("%m/%d/%Y"), start_time.strftime("%l:%M%p"),
          show[:channel]
        ]
      end
    end
  end
end
