# frozen_string_literal: true

describe Services::Rover::ExecuteInstructions do
  let(:rover)        { Models::Rover.new([0, 0], [5, 5], "E") }
  let(:instructions) { %w[M L M R] }

  subject { described_class.new(rover, instructions) }

  describe "initialization" do
    context "when constructor is called with rover and instructions" do
      it_behaves_like "successful initialization"
    end

    context "when constructor is called without params" do
      subject { described_class.new }
      it_behaves_like "failed initialization"
    end

    context "when constructor is called with only rover" do
      subject { described_class.new(rover) }
      it_behaves_like "failed initialization"
    end

    context "when constructor is called with rover and instructions alongside other params" do
      subject { described_class.new(rover, instructions, "SomeOtherParam") }
      it_behaves_like "failed initialization"
    end
  end

  shared_examples "call execution examples" do
    let(:instructions) { %w[M L M R] }

    it "calls .execute_instruction for all the instructions individually" do
      expect(rover).to have_received(:execute_instruction).exactly(4).times
    end

    it "calls .execute_instruction with right instructions" do
      expect(rover).to have_received(:execute_instruction).with("M").exactly(2).times
      expect(rover).to have_received(:execute_instruction).with("R").once
      expect(rover).to have_received(:execute_instruction).with("L").once
    end
  end

  describe ".call" do
    before do
      allow(rover).to receive(:execute_instruction)
      subject.call
    end

    include_examples "call execution examples"
  end

  describe "#call" do
    subject { described_class.call(rover, instructions) }

    before do
      allow(rover).to receive(:execute_instruction)
      subject
    end

    include_examples "call execution examples"
  end
end
