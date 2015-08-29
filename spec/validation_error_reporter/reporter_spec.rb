require "spec_helper"

describe ValidationErrorReporter::Reporter do

  let(:configuration) { ValidationErrorReporter::Configuration.new }
  let(:subject) { described_class.new(configuration) }

  describe "initialize(configration)" do
    it "assigns notifiers from the configuration" do
      expect(subject.notifiers).to eq(configuration.notifiers)
    end
  end

  describe "#report(error)" do
    it "sends all the failed records to the notifiers" do
      error = double(:to_s)

      expect(error).to receive(:to_s).exactly(1).times
      expect_any_instance_of(ValidationErrorReporter::Notifiers::Console).to receive(:notify).exactly(1).times

      subject.report(error)
    end
  end

  describe "#finalize" do
    it "finalizes all notifiers" do
      expect_any_instance_of(ValidationErrorReporter::Notifiers::Console).to receive(:finalize).exactly(1).times
      subject.finalize
    end
  end

end
