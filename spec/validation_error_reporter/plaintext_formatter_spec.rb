require "spec_helper"

describe ValidationErrorReporter::PlaintextFormatter do

  describe ".format" do
    it "formats the text for email" do
      bank1 = Bank.new(name: "F")
      bank1.save(validate: false)
      bank1.valid?

      bank2 = Bank.new
      bank2.save(validate: false)
      bank2.valid?

      report = ValidationErrorReporter::ErrorReport.new([bank1, bank2])

      expect(described_class.new(report).format).to eq(
        "Bank 1:\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "Bank 2:\n" +
        "  Name can't be blank\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "Total Errors: 3"
      )
    end
  end
end
