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

    context "when expedition is passed alongside other params in constructor" do
      subject { described_class.new(expedition, "SomeOtherParam") }
      it_behaves_like "failed initialization"
    end
  end
end
