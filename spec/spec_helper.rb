require "rspec"

#
# Generate show
#
def gen_show(day, time, channel, running_length)
  today = Date.today
  { 
    start_time: Time.new(today.year, today.month, day, time), 
    channel: channel.to_i,
    running_length: running_length * 60,
  }
end
