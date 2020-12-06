# frozen_string_literal: true

describe Services::Expedition::Setup do
  let(:input) { "Input" }
  subject { described_class.new(input) }

  describe "initialization" do
    context "when input is passed in constructor" do
      it_behaves_like "successful initialization"

      it "initializes default values" do
        expect(subject.expedition).to be_a(Models::Expedition)
      end
    end

    context "when no params are passed in constructor" do
      subject { described_class.new }
      it_behaves_like "failed initialization"
    end

    context "when input is passed alongside other params in constructor" do
      subject { described_class.new(input, "ExtraParam") }
      it_behaves_like "failed initialization"
    end
  end

  shared_examples "call execution examples" do
    let(:input) do
      <<~HEREDOC
        5 5
        1 2 N
        LMLMLMLMM
        3 3 E
        MMRMMRMRRM
      HEREDOC
    end

    it "returns an instance of Models::Expedition" do
      expect(subject).to be_a(Models::Expedition)
    end

    context "expedition information" do
      context ".rovers" do
        let(:rovers) { subject.rovers }
        it "returns expected number of rovers" do
          expect(rovers.length).to eq(2)
        end

        it "returns expected information for rover" do
          rover = rovers[0]
          expect(rover.x_coordinate).to eq(1)
          expect(rover.y_coordinate).to eq(2)
          expect(rover.orientation).to  eq("N")
        end
      end

      context ".rovers_instructions" do
        let(:rover_instructions) { subject.rovers_instructions }
        it "returns expected number of rover instructions" do
          expect(rover_instructions.length).to eq(2)
        end

        it "returns instructions in an array of instructions" do
          expect(rover_instructions[0]).to match_array(%w[L M L M L M L M M])
        end
      end

      context ".ending_coordinates" do
        let(:ending_coordinates) { subject.ending_coordinates }
        it "returns ending coordinates" do
          expect(ending_coordinates).to match_array([5, 5])
        end
      end
    end
  end

  describe ".call" do
    subject { described_class.new(input).call }
    include_examples "call execution examples"
  end

  describe "#call" do
    subject { described_class.call(input) }
    include_examples "call execution examples"
  end
end
