# frozen_string_literal: true

describe Models::Expedition do
  subject { described_class.new }

  describe "initialization" do
    context "when constructor is called without params" do
      it_behaves_like "successful initialization"

      it "sets rovers as an empty array" do
        expect(subject.rovers).to match_array([])
      end

      it "sets rovers_instructions as an empty array" do
        expect(subject.rovers_instructions).to match_array([])
      end

      it "sets starting_coordinates as [0,0]" do
        expect(subject.starting_coordinates).to match_array([0, 0])
      end

      it "sets ending_coordinates as [0,0]" do
        expect(subject.ending_coordinates).to match_array([0, 0])
      end
    end

    context "when constructor is called with params" do
      subject { described_class.new("SomeParam") }
      it_behaves_like "failed initialization"
    end
  end
end
