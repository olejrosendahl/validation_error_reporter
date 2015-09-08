require "spec_helper"

describe ValidationErrorReporter::Notifiers::Console do
  let(:subject) { described_class.new(double) }

  describe "#notify" do
    it "sends its message to it's output" do
      printer = double
      notifier = described_class.new(double, printer)

      expect(printer).to receive(:puts).with(:message)

      notifier.notify(:message)
    end
  end

end
