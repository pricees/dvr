require_relative "../lib/dvr.rb"
require "csv"
require "time"

dir      = File.dirname(__FILE__)
user_fn  = "#{dir}/user_schedule.csv"
tv_fn    = "#{dir}/tv_schedule.csv"
showtimes = [] 

device = Dvr::Device.new(1)

user_schedule = CSV.read(user_fn)
CSV.foreach(tv_fn) do |row|
  time, channel, mins = row
  showtimes << { 
    start_time: Time.parse(time),
    channel: channel.to_i,
    running_length: mins.to_i * 60,
  }
end

Dvr::TvSchedule.instance.showtimes = showtimes
Dvr::Scheduler.instance.update_user_schedule(
  Dvr::InputParser.parse(user_schedule))

schedule = Dvr::Scheduler.instance.schedule
output = Dvr::Encoding.output schedule 

puts "\n=============================\nTV SHOW SCHEDULE\n"
puts "\nDate & Time, Channel, Running Time (min)\n"
puts "#{File.read(tv_fn)}"
puts "\n=============================\nUSER RECORDING SCHEDULE\n"
puts "\nDate, Start & End Time, Channel\n"
puts "#{File.read(user_fn)}"
puts "\n====DEVICE has #{device.tuners} tuner ==== "
puts "\n=============================\nDVR SCHEDULE\n"
puts output.map { |line| line.join("\t") }.join("\n")


puts "\nBump our device to 2 tuners...."
device = Dvr::Device.new(2)
Dvr::TvSchedule.instance.showtimes = showtimes
Dvr::Scheduler.instance.update_user_schedule(
  Dvr::InputParser.parse(user_schedule))

schedule = Dvr::Scheduler.instance.schedule
output = Dvr::Encoding.output schedule 

puts "\n====DEVICE has #{device.tuners} tuner ==== "
puts "\n=============================\nDVR SCHEDULE\n"
puts output.map { |line| line.join("\t") }.join("\n")
