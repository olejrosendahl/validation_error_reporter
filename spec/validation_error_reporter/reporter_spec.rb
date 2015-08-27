require "spec_helper"

describe ValidationErrorReporter::Reporter do

  describe "#report(errors)" do
    it "sends all the failed records to the notifiers" do
      error = double(:to_s)

      expect(error).to receive(:to_s).exactly(1).times
      expect_any_instance_of(ValidationErrorReporter::Notifier).to receive(:notify).exactly(1).times

      subject.report([error])
    end
  end

end
