require "spec_helper"

describe ValidationErrorReporter::Notifier do

  describe "#notify" do
    it "sends its message to it's output" do
      expect_any_instance_of(ValidationErrorReporter::Formatter).to receive(:output).with(:message)
      subject.notify(:message)
    end
  end

end
