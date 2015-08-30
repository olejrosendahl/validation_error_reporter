require "spec_helper"

describe ValidationErrorReporter::Runner do

  describe "#run(options)" do
    it "validates all models" do
      subject.run
      expect(subject.instance_exec { @models }).to eq([Company, Project])
    end

    context "when given models" do
      subject { described_class.new(models: ["Company"]) }

      it "validates the given models only" do
        expect(ValidationErrorReporter::Entity).to receive(:models_for).with(["Company"])
        expect(subject).to receive(:run_validations)

        subject.run
      end
    end

  end

end
