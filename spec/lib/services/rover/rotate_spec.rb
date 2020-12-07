# frozen_string_literal: true

describe Services::Rover::Rotate do
  let(:x_coordinate)         { 1 }
  let(:y_coordinate)         { 1 }
  let(:ending_x_coordinate)  { 5 }
  let(:ending_y_coordinate)  { 5 }
  let(:orientation)          { "E" }
  let(:rotation_direction)   { "L" }

  let(:rover) do
    Models::Rover.new([x_coordinate, y_coordinate],
                      [ending_x_coordinate, ending_y_coordinate],
                      orientation)
  end

  subject { described_class.new(rover, rotation_direction) }

  describe "initialization" do
    context "when constructor is called with rover and direction" do
      it_behaves_like "successful initialization"
    end

    context "when constructor is called without params" do
      subject { described_class.new }
      it_behaves_like "failed initialization"
    end

    context "when constructor is called with rover and rotation alongside other param" do
      subject { described_class.new(rover, rotation_direction, "ExtraParam") }
      it_behaves_like "failed initialization"
    end
  end

  describe "::CONFIGURATION" do
    let(:expected_configuration) do
      {
        NR: "E", NL: "W", ER: "S", WR: "N",
        EL: "N", SR: "W", SL: "E", WL: "S"
      }
    end

    subject { described_class::CONFIGURATION }

    it "includes all rotation cases" do
      expect(subject).to eq(expected_configuration)
    end
  end

  describe ".configuration_key" do
    subject { described_class.new(rover, rotation_direction).configuration_key }

    it "returns rover's orientation and direction combined as symbol" do
      expect(subject).to eq("#{rover.orientation}#{rotation_direction}".to_sym)
    end
  end

  shared_examples "call execution examples" do
    context "when rover is oriented 'E'(east)" do
      let(:orientation) { "E" }

      context "when rotation is 'R'(right)" do
        let(:rotation_direction) { "R" }
        it "returns 'S'(south)" do
          expect(subject).to eq("S")
        end
      end

      context "when rotation is 'L'(left)" do
        let(:rotation_direction) { "L" }
        it "returns 'N'(north)" do
          expect(subject).to eq("N")
        end
      end
    end

    context "when rover is oriented 'S'(south)" do
      let(:orientation) { "S" }

      context "when rotation is 'R'(right)" do
        let(:rotation_direction) { "R" }
        it "returns 'W'(west)" do
          expect(subject).to eq("W")
        end
      end

      context "when rotation is 'L'(left)" do
        let(:rotation_direction) { "L" }
        it "returns 'E'(east)" do
          expect(subject).to eq("E")
        end
      end
    end

    context "when rover is oriented 'W'(west)" do
      let(:orientation) { "W" }

      context "when rotation is 'R'(right)" do
        let(:rotation_direction) { "R" }
        it "returns 'N'(north)" do
          expect(subject).to eq("N")
        end
      end

      context "when rotation is 'L'(left)" do
        let(:rotation_direction) { "L" }
        it "returns 'S'(south)" do
          expect(subject).to eq("S")
        end
      end
    end

    context "when rover is oriented 'N'(north)" do
      let(:orientation) { "N" }

      context "when rotation is 'R'(right)" do
        let(:rotation_direction) { "R" }
        it "returns 'E'(east)" do
          expect(subject).to eq("E")
        end
      end

      context "when rotation is 'L'(left)" do
        let(:rotation_direction) { "L" }
        it "returns 'W'(west)" do
          expect(subject).to eq("W")
        end
      end
    end

    context "when combination of orientation and direction is unknown" do
      context "when orientation is unknown" do
        let(:orientation) { "D" }

        it "raises NotImplementedError" do
          expect { subject }.to raise_error(NotImplementedError)
        end
      end

      context "when rotation direction is unknown" do
        let(:rotation_direction) { "W" }

        it "raises NotImplementedError" do
          expect { subject }.to raise_error(NotImplementedError)
        end
      end
    end
  end

  describe ".call" do
    subject { described_class.new(rover, rotation_direction).call }
    include_examples "call execution examples"
  end

  describe "#call" do
    subject { described_class.call(rover, rotation_direction) }
    include_examples "call execution examples"
  end
end
