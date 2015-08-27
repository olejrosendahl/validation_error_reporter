require "spec_helper"

describe ValidationErrorReporter::Runner do

  describe ".run(options)" do
    it "invokes the validator and generates a report" do
      asserted_models = ["Model1", "Model2"]

      expect(described_class).to receive(:models_for).with(asserted_models)
      expect(described_class).to receive(:run_validations)

      described_class.run(models: asserted_models)
    end
  end

end
