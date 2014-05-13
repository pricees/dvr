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
        [ double(approximate_space: 1E9),
          double(approximate_space: 8E9),
          double(approximate_space: 2E9),]
      end

      before do
        subject.recordings = recordings
      end

      it "has some space remaining" do
        expect(subject.space_remaining).to eq(189E9)
      end
    end
  end
end
