require "spec_helper"

describe ValidationErrorReporter::ErrorFinder do

  describe ".get_errors(models)" do
    it "returns no errors on valid models" do
      Project.create(name: "World Project")
      expect(described_class.get_errors([Project])).to eq([])
    end

    it "returns errors on invalid models" do
      test_bank_2 = Project.new
      test_bank_2.save(validate: false)
      test_bank_2.valid?
      expect(described_class.get_errors([Project])).to eq([[test_bank_2.class.model_name.human,
                                 test_bank_2.id, test_bank_2.errors.full_messages]])
    end
  end
end
