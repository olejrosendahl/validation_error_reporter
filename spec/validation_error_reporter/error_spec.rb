require "spec_helper"

module ValidationErrorReporter
  describe Error do
    subject do
      described_class.new(double(
        id: 1,
        class: double(
          model_name: double(name: "Project", human: "Project"),
          count: 1,
          primary_key: :id
        ),
        errors: double(
          full_messages: [
            "Name can't be blank",
            "Name is too short (minimum is 2 characters)"]
        )
      ))
    end

    describe "#to_s" do
      it "outputs the records with the errors" do
        expect(subject.to_s).to eq(
          "Project 1:\n" +
          "  Name can't be blank\n" +
          "  Name is too short (minimum is 2 characters)"
        )
      end
    end

    describe "#model_name" do
      it "returns the name of the wrapped model record" do
        expect(subject.model_name).to eq("Project")
      end
    end

    describe "#model_total_count" do
      it "return the total number of records for the model" do
        expect(subject.model_total_count).to eq(1)
      end
    end
  end

end
