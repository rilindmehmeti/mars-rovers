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
      allow(Services::Rover::Move).to receive(:call).and_return([5, 5])
      subject.move
    end

    it "changes x and y coordinates" do
      expect(subject.x_coordinate).to eq(5)
      expect(subject.y_coordinate).to eq(5)
    end
  end

  describe ".rotate" do
    before do
      allow(Services::Rover::Rotate).to receive(:call).and_return("W")
      subject.rotate("L")
    end

    it "changes the direction" do
      expect(subject.orientation).to eq("W")
    end
  end
end
