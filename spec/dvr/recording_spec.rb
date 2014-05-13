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
end
