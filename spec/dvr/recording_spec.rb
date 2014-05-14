require "spec_helper"
require_relative "../../lib/dvr.rb"

describe Dvr::Recording do
  describe "#recordable?" do
    context "a show that runs 1:05 that start an hour ago" do
      let(:recording) do
        Dvr::Recording.new(start_time: Time.now - 3600, # one hour ago
                           running_length: 3900)
      end

      it "is still recordable" do
        expect(recording).to be_recordable
      end
    end

    context "a show that ended ~30 mins ago" do
      let(:recording) do
        Dvr::Recording.new(start_time: Time.now - 3600, # one hour ago
                           running_length: 1800)
      end

      it "is not recordable" do
        expect(recording).to_not be_recordable
      end
    end

    context "a show that starts in ~10 mins " do
      let(:recording) do
        Dvr::Recording.new(start_time: Time.now + 300)
      end

      it "is not recordable" do
        expect(recording).to_not be_recordable
      end
    end

    context "a show that starts in ~1 mins " do
      let(:recording) { Dvr::Recording.new(start_time: Time.now + 60, 
                                           running_length: 600) }

      it "is recordable" do
        expect(recording).to be_recordable
      end
    end
  end

  describe "#full_size" do
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
