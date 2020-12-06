# frozen_string_literal: true

describe Services::Rover::Move do
  let(:x_coordinate) { 1 }
  let(:y_coordinate) { 1 }
  let(:orientation)  { "E" }

  let(:rover) do
    Models::Rover.new([x_coordinate, y_coordinate], orientation)
  end

  subject { described_class.new(rover) }

  describe "initialization" do
    context "with rover" do
      it_behaves_like "successful initialization"
    end

    context "without params" do
      subject { described_class.new }
      it_behaves_like "failed initialization"
    end

    context "with other params then rover" do
      subject { described_class.new(rover, "ExtraParam") }
      it_behaves_like "failed initialization"
    end
  end

  shared_examples "call execution examples" do
    context "when orientation is 'E'(east) " do
      it "increases x coordinate, leaves y coordinate the same" do
        expect(subject).to eq([(x_coordinate + 1), y_coordinate])
      end
    end

    context "when orientation is 'W'(west) " do
      let(:orientation) { "W" }
      it "decreases x coordinate, leaves y coordinate the same" do
        expect(subject).to eq([(x_coordinate - 1), y_coordinate])
      end
    end

    context "when orientation is 'N'(north) " do
      let(:orientation) { "N" }
      it "increases y coordinate, leaves x coordinate the same" do
        expect(subject).to eq([x_coordinate, (y_coordinate + 1)])
      end
    end

    context "when orientation is 'S'(south) " do
      let(:orientation) { "S" }
      it "decreases y coordinate, leaves x coordinate the same" do
        expect(subject).to eq([x_coordinate, (y_coordinate - 1)])
      end
    end

    context "when orientation is not included in ['E','S','W','N']" do
      let(:orientation) { "O" }
      it "raises NotImplementedError" do
        expect { subject }.to raise_error(NotImplementedError)
      end
    end
  end

  describe ".call" do
    subject { described_class.new(rover).call }
    include_examples "call execution examples"
  end

  describe "#call" do
    subject { described_class.call(rover) }
    include_examples "call execution examples"
  end
end
