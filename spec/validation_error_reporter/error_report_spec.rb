require "spec_helper"

describe ValidationErrorReporter::ErrorReport do

  def create_project(name)
    project = Project.new(name: name)
    project.save(validate: false)
    project.valid?
    project
  end

  def create_company(name)
    company = Company.new(name: name)
    company.save(validate: false)
    company.valid?
    company
  end

  let(:invalid_records) do
    [create_company("f"), create_company("Company 1"),
     create_company("Company 2"), create_project("Project 1"),
     create_project(nil)]
  end

  describe "#generate" do
    it "generates a formatted report" do
      expect(described_class.new(invalid_records, ValidationErrorReporter::PlaintextFormatter.new).generate).to eq(
        "Company 1:\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "Project 2:\n" +
        "  Name can't be blank\n" +
        "  Name is too short (minimum is 2 characters)\n" +
        "\n" +
        "Summary:\n" +
        "Model with most errors: Company (3 entries, 1 error(s)).\n" +
        "Model with highest error rate: Project (2 entries, 1 error(s), 50.0%)."
      )
    end
  end
end
