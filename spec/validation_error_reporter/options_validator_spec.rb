require "spec_helper"
require_relative "../../lib/validation_error_reporter/options_validator"

describe ValidationErrorReporter::OptionsValidator do

  describe ".validate!(options)" do
    it "throws errors for missing parameters" do
      expect {
        described_class.validate!(email_to: "you@example.com")
      }.to raise_error(ArgumentError, "Missing required option 'email_from'")
      expect {
        described_class.validate!(email_from: "me@example.com")
      }.to raise_error(ArgumentError, "Missing required option 'email_to'")
    end

    it "throws errors on non-existing models" do
      expect {
        described_class.validate!(models: "Woohoo")
      }.to raise_error ArgumentError, "Chosen model 'Woohoo' does not exist"
    end
  end
end
