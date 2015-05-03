require "spec_helper"
require_relative "../../lib/show_model_errors/options_validator"

describe ShowModelErrors::OptionsValidator do

  describe ".validate!(options)" do
    it "throws errors for missing parameters" do
      expect {
        described_class.validate!(email_to: "you@example.com")
      }.to raise_error(ArgumentError, "Missing required option 'mail_from'")
      expect {
        described_class.validate!(email_from: "me@example.com")
      }.to raise_error(ArgumentError, "Missing required option 'mail_to'")
    end
  end
end
