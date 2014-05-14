require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Scheduler do

  let(:showtimes) do
    [
      # Ch 1
      { start_time: Time.new(2014, 02, 11, 17), channel: 1 },
      { start_time: Time.new(2014, 02, 11, 19), channel: 1 },
      # Ch 3
      { start_time: Time.new(2014, 02, 11, 17), channel: 3 },
      { start_time: Time.new(2014, 02, 11, 19), channel: 3 },
      { start_time: Time.new(2014, 02, 11, 20), channel: 3 },
      { start_time: Time.new(2014, 02, 11, 21), channel: 3 },
      { start_time: Time.new(2014, 02, 11, 22), channel: 3 },
      # Ch 4
      { start_time: Time.new(2014, 02, 11, 17), channel: 4 },
      { start_time: Time.new(2014, 02, 11, 19), channel: 4 },
      # Nothing for Ch 5
      # Ch 6
      { start_time: Time.new(2014, 02, 12, 17), channel: 6 },
      { start_time: Time.new(2014, 02, 12, 19), channel: 6 },
    ]
  end

  let(:user_schedule) do
    [
      ["02/11/2014", "5:00pm-8:00pm", "1"],
      ["02/11/2014", "5:00pm-8:00pm", "3"],
      ["02/11/2014", "8:00pm-9:00pm", "4"],
      ["02/11/2014", "10:00pm-11:00pm", "3"],
      ["02/12/2014", "5:00pm-8:00pm", "5"],
    ]
  end

  before do
    Dvr::Scheduler.instance.user_schedule = Dvr::InputParser.new.parse user_schedule
    Dvr::TvSchedule.instance.showtimes = showtimes
  end

  describe "#encode_schedule" do


    it "response with an current schedule of recordings" do
    end
  end
end
