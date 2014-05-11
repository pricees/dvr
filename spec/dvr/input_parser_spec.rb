require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::InputParser do

  describe "#parse" do
    let(:input) { [["02/11/2014", "5:00pm-8:00pm", "314"]] }

    before { @res = subject.parse(input) }

    it "parse a start time" do
      start_time = Time.new(2014, 2, 11, 17)
      expect(@res.first[:start_time]).to eq(start_time)
    end

    it "parse a end time" do
      end_time = Time.new(2014, 2, 11, 20)
      expect(@res.first[:end_time]).to eq(end_time)
    end

    it "parses a channel" do
      expect(@res.first[:channel]).to eq("314")
    end
  end
end
