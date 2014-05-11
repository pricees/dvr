module Dvr
  class InputParser

    def parse(input)
      input.map do |schedule|
        to_hash schedule
      end
    end

    private 

    def to_hash(schedule)
      start_time, end_time = split_time(*schedule[0,2])

      { 
        start_time: start_time,
        end_time: end_time,
        channel: schedule[2]
      }
    end

    #
    # Assumes the following format:
    #   date - "MONTH/DAY/YEAR"
    #   time span - "HOUR:MINUTE(meridian)-HOUR:MINUTE(meridian)
    #
    def split_time(date, time_span)
      month, day, year = date.split(/\//)

      new_date = "#{year}-#{month}-#{day}"
      start_time, end_time = time_span.split /-/

      [Time.parse("#{new_date} #{start_time}"),
        Time.parse("#{new_date} #{end_time}")]
    end
  end
end
