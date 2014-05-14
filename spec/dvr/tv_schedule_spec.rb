require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::TvSchedule do

  describe "#next_show" do

    context "channel has no programming" do
      before do
        Dvr::TvSchedule.instance.stub(:showtimes).and_return([])
      end

      it "returns nil" do
        expect(Dvr::TvSchedule.instance.next_show(1)).to be_nil
      end
    end

    context "show is available" do
      let(:next_show) do
        { :end_time => Time.now + 30 }
      end

      let(:shows) do
        { Time.now + 1 => next_show, Time.now + 3600 => double }
      end

      before do
        Dvr::TvSchedule.instance.stub(:showtimes).and_return(1 => shows)
      end

      context "defaults time to now" do
        it "returns the next show on a change" do
          time = Time.now
          res = Dvr::TvSchedule.instance.next_show(1, time, time + 1800)
          expect(res).to eq(next_show)
        end
      end
    end
  end
end
