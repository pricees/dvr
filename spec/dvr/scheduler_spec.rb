require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Scheduler do

  let(:showtimes) do
    today = Date.today.day
    [
      # Ch 1
      gen_show(today, 17, 1, 60),
      gen_show(today, 19, 1, 60),
      # Ch 3
      gen_show(today, 17, 3, 60),
      gen_show(today, 18, 3, 60),
      gen_show(today, 19, 3, 30),
      gen_show(today, 20, 3, 30),
      gen_show(today, 21, 3, 30),
      gen_show(today, 22, 3, 60),
      # Ch 4
      gen_show(today, 17, 4, 30),
      gen_show(today, 19, 4, 60),
      # Nothing for Ch 5
      # Ch 6
      gen_show(today+1, 17, 6, 30),
      gen_show(today+1, 19, 6, 60),
    ]
  end

  let(:user_schedule) do
    today = Date.today.strftime("%m/%d/%Y")
    [
      [today, "5:00pm-8:00pm", "1"],
      [today, "5:00pm-8:00pm", "3"],
      [today, "8:00pm-9:00pm", "4"],
      [today, "10:00pm-11:00pm", "3"],
      [today, "5:00pm-8:00pm", "5"],
    ]
  end

  before do
    Dvr::Scheduler.instance.user_schedule = Dvr::InputParser.new.parse user_schedule

    Dvr::TvSchedule.instance.showtimes = showtimes
  end

  describe "#update_recording_schedule" do
    it "updates_the_schedule" do
      Dvr::Scheduler.instance.update_recording_schedule Time.now
      puts
      p Dvr::Scheduler.instance.schedule
      p Dvr::Encoding.output Dvr::Scheduler.instance.schedule
    end
  end
  describe "#channels_at_time" do
    let(:time) do
      t = Date.today
      Time.new(t.year, t.month, t.day, 17)
    end

    it "returns all channels for day at 5pm" do
      res = Dvr::Scheduler.instance.channels_for_time(time)
      expect(res).to eq(%w[1 3 5])
    end

    it "returns all channels for day at 10pm" do
      res = Dvr::Scheduler.instance.channels_for_time(time + (5 * 3600))
      expect(res).to eq(%w[3])
    end

    it "returns all channels for 100 hours from now" do
      res = Dvr::Scheduler.instance.channels_for_time(time + (100 * 3600))
      expect(res).to eq(%w[])
    end
  end

  describe "#encode_schedule" do

    it "response with an current schedule of recordings" do
    end
  end
end
