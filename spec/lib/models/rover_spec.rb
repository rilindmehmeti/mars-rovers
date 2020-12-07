# frozen_string_literal: true

describe Models::Rover do
  subject { described_class.new([0, 0], "E") }

  describe "::MOVE_INSTRUCTION" do
    subject { described_class::MOVE_INSTRUCTION }
    it "matches 'M'" do
      expect(subject).to eq("M")
    end
  end

  describe "::ROTATE_INSTRUCTIONS" do
    subject { described_class::ROTATE_INSTRUCTIONS }
    it "matches ['R','L']" do
      expect(subject).to match_array(%w[R L])
    end
  end

  describe "initialization" do
    context "when constructor is called coordinates and orientation" do
      it_behaves_like "successful initialization"
    end

    context "when constructor is not called correctly" do
      context "when constructor is called with coordinates only" do
        subject { described_class.new([0, 0]) }

        it_behaves_like "failed initialization"
      end

      context "when constructor is called with more params than expected" do
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

  describe ".execute_instruction" do
    before do
      allow(subject).to receive(:move)
      allow(subject).to receive(:rotate)
      subject.execute_instruction(instruction)
    end

    context "when 'M' is passed as instruction" do
      let(:instruction) { "M" }
      it "calls move method" do
        expect(subject).to have_received(:move).once
      end
    end

    context "when 'R' is passed as instruction" do
      let(:instruction) { "R" }
      it "calls rotate method with 'R' as direction" do
        expect(subject).to have_received(:rotate).with("R").once
      end
    end

    context "when 'L' is passed as instruction" do
      let(:instruction) { "L" }
      it "calls rotate method with 'L' as direction" do
        expect(subject).to have_received(:rotate).with("L").once
      end
    end
  end

  describe ".print" do
    it "returns x_coordinate, y_coordinate and orientation concatenated with space" do
      expect(subject.print).to eq("0 0 E")
    end
  end
end
