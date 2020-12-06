# frozen_string_literal: true

shared_examples "successful initialization" do
  it "doesn't raise errors" do
    expect { subject }.not_to raise_error
  end
end

shared_examples "failed initialization" do
  it "raises ArgumentError" do
    expect { subject }.to raise_error(ArgumentError)
  end
end
