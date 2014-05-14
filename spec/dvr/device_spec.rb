require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Device do

  describe "#tuners" do

  end

  describe "#space_remaining" do
    context "with zero recordings" do
      it "has all space remaining" do
        expect(subject.space_remaining).to eq(subject.total_space)
      end

      it "has space available" do
        expect(subject).to be_space_remaining
      end
    end

    context "with recordings" do
      let (:recordings) do
        [ double(full_size: 1E9),
          double(full_size: 8E9),
          double(full_size: 2E9),]
      end

      before do
        subject.recordings = recordings
      end

      it "has some space remaining" do
        expect(subject.space_remaining).to eq(189E9)
      end
    end
  end

  describe "#play" do
    let(:device) { Dvr::Device.new }

    before do
      device.recordings << double << double
    end

    it "passes recording to Play#do" do
      Dvr::Play.should_receive(:do).with(device.recordings[1])
      device.play 1
    end
  end
end
