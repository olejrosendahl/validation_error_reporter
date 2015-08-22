require "spec_helper"

describe ValidationErrorReporter::ErrorFinder do

  describe ".get_errors(models)" do
    it "returns no errors on valid models" do
      Project.create(name: "World Project")
      expect(described_class.get_errors([Project])).to eq([])
    end

    it "returns errors on invalid models" do
      test_project_2 = Project.new
      test_project_2.save(validate: false)
      test_project_2.valid?
      expect(described_class.get_errors([Project])).to eq([[test_project_2.class.model_name.human,
                                 test_project_2.id, test_project_2.errors.full_messages]])
    end
  end
end
