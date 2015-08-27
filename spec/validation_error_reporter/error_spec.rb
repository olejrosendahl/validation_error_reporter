require "spec_helper"

describe ValidationErrorReporter::Error do

  describe "#to_s" do
    it "outputs the records with the errors" do
      klass = double(model_name: double(human: "Project"), primary_key: :id)
      errors = double(full_messages: ["Name can't be blank", "Name is too short (minimum is 2 characters)"])
      project = double(class: klass, id: 1, errors: errors)

      expect(described_class.new(project).to_s).to eq(
        "Project 1:\n" +
        "  Name can't be blank\n" +
        "  Name is too short (minimum is 2 characters)"
      )
    end
  end
end
