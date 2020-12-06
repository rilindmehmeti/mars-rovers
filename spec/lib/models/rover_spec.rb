# frozen_string_literal: true

describe Models::Rover do
  subject { described_class.new([0, 0], "E") }

  describe "initialization" do
    context "with coordinates and orientation" do
      it_behaves_like "successful initialization"
    end

    context "without all required params" do
      context "with only coordinates" do
        subject { described_class.new([0, 0]) }

        it_behaves_like "failed initialization"
      end

      context "with more params" do
        subject { described_class.new([0, 0], "E", "ExtraParam") }

        it_behaves_like "failed initialization"
      end
    end
  end

  describe ".move" do
    before do
      subject.move
    end

    xit "changes x and y coordinates" do
      subject
    end
  end

  describe ".rotate" do
    before do
      subject.rotate
    end

    xit "changes the direction" do
      subject
    end
  end
end
