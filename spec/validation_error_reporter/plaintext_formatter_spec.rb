require "spec_helper"

describe ValidationErrorReporter::PlaintextFormatter do

  describe ".format" do
    it "formats the text for email" do
      errors = [
        ["Bank", 1, ["ID is missing", "Something wrong"]],
        ["Bank", 2, ["Wrong format"]]
      ]

      expect(described_class.new(errors).format).to eq(
        "Bank 1:\n" +
        "  ID is missing\n" +
        "  Something wrong\n" +
        "Bank 2:\n" +
        "  Wrong format\n" +
        "Total Errors: 3"
      )
    end
  end
end
