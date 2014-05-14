require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Device do

  describe "#space_available" do
    context "with zero recordings" do
      it "has all space available" do
        expect(subject.space_available).to eq(subject.total_space)
      end

      it "has space available" do
        expect(subject).to be_space_available
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

      it "has some space available" do
        expect(subject.space_available).to eq(189E9)
      end
    end
  end

  describe "recordable?" do
    let(:device) { Dvr::Device.new(1, 100) }

    it "return true if enough space" do
      recording = double(full_size: 99) 

      expect(device.recordable?(recording)).to be_true
    end

    it "returns false if not enough space" do
      recording = double(full_size: 101) 

      expect(device.recordable?(recording)).to be_false
    end
  end

  describe "#record" do
    let(:device) { Dvr::Device.new }

    it "returns false if all tuners are being used" do
      device.stub(:recordable?).and_return false

      expect(device.record(double)).to be_false
    end

    it "passes index of tuner that is recording" do
      device.stub(:recordable?).and_return true

      recording = double(:record! => true) 
      expect(device.record(recording)).to eq(0)
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

  describe "#open_tuner" do

    context "all tuners are unused" do
      it "returns index of 0" do
        expect(subject.open_tuner).to eq(0)
      end
    end

    context "1 tuner available" do
      before do 
        subject.current_recordings.clear
        subject.current_recordings[0] = double
      end

      it "returns index of 0" do
        expect(subject.open_tuner).to eq(1)
      end
    end

    context "all tuners are used" do
      before do 
        subject.current_recordings.clear
        subject.tuners.times { |t| subject.current_recordings[t] = double }
      end

      it "returns index of 0" do
        expect(subject.open_tuner).to be_nil
      end
    end
  end
end
