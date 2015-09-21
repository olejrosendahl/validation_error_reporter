require "spec_helper"

module ValidationErrorReporter
  describe Entity do
    describe ".models_for(model_names)" do
      it "returns all models" do
        expect(described_class.models_for).to eq([Company, Project])
      end

      context "when when given a list of models as strings" do
        it "resolved the models that exists in the application" do
          expect(described_class.models_for(["Company", "Model1"])).to eq([Company])
        end
      end
    end
  end
end
