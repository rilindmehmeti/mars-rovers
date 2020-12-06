# frozen_string_literal: true

describe Services::Expedition::Navigate do
  let(:expedition) { Models::Expedition.new }

  subject { described_class.new(expedition) }
  describe "initialization" do
    context "when expedition is passed in constructor" do
      it_behaves_like "successful initialization"
    end

    context "when no params are passed in constructor" do
      subject { described_class.new }
      it_behaves_like "failed initialization"
    end

    context "when expedition is passed alongside other params" do
      subject { described_class.new(expedition, "SomeOtherParam") }
      it_behaves_like "failed initialization"
    end
  end

  shared_examples "call execution examples" do
    let(:first_rover)  { Models::Rover.new([1, 1], "W") }
    let(:second_rover) { Models::Rover.new([0, 0], "E") }
    let(:instructions) { %w[L L M R L] }

    before do
      allow(expedition).to receive(:rovers).and_return([first_rover, second_rover])
      allow(expedition).to receive(:rovers_instructions).and_return([instructions, instructions])

      allow(Services::Rover::ExecuteInstructions).to receive(:call)
      subject
    end

    it "calls Services::Rover::ExecuteInstructions for each rover" do
      expect(Services::Rover::ExecuteInstructions).to have_received(:call).exactly(2).times
    end

    it "calls Services::Rover::ExecuteInstructions with correct params" do
      expect(Services::Rover::ExecuteInstructions).to have_received(:call)
        .with(first_rover, instructions).once

      expect(Services::Rover::ExecuteInstructions).to have_received(:call)
        .with(second_rover, instructions).once
    end
  end

  describe ".call" do
    subject { described_class.new(expedition).call }
    include_examples "call execution examples"
  end

  describe "#call" do
    subject { described_class.call(expedition) }
    include_examples "call execution examples"
  end
end
