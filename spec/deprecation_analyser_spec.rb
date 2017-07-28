require "spec_helper"

RSpec.describe DeprecationAnalyser do
  it "has a version number" do
    expect(DeprecationAnalyser::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
