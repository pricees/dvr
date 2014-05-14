require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Recording do
  describe "#recording?" do
    context "a show that is still running" do
      let(:show) do
        { start_time: Time.now - 3600, # one hour ago
          running_length: 1800, # half hour
        }
      end

      before { @recording = Dvr::Recording.new(show) }

      it "is still running" do
        expect(@recording).to_not be_running
      end
    end

    context "a show that is not running" do
      let(:show) do
        { start_time: Time.now - 3600, # one hour ago
          running_length: 3605, # half hour
        }
      end

      before { @recording = Dvr::Recording.new(show) }

      it "is still running" do
        expect(@recording).to be_running
      end
    end
  end

  describe "#space_available" do

    describe "sd resolution" do
      let(:recording) do
        Dvr::Recording.new({ running_length: 300,
                           resolution: :sd })
      end

      it "takes 7.2 gig of space" do
        expect(recording.full_size).to eq(7_200)
      end
    end
  end
end
