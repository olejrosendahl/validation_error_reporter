require "spec_helper"

describe ValidationErrorReporter::PlaintextFormatter do

  describe ".format" do
    it "formats the text for email" do
      project1 = Project.new(name: "F")
      project1.save(validate: false)
      project1.valid?

      project2 = Project.new
      project2.save(validate: false)
      project2.valid?

      report = ValidationErrorReporter::ErrorReport.new([project1, project2])

      expect(described_class.new(report).format).to eq(
        "Project 1:\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "Project 2:\n" +
        "  Name can't be blank\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "Total Errors: 3"
      )
    end
  end
end
