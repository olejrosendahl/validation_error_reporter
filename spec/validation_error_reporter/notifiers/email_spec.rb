require "spec_helper"

describe ValidationErrorReporter::Notifiers::Email do
  include Mail::Matchers

  let(:configuration) do
    ValidationErrorReporter::Configuration.new(from: "from@example.com", to: "to@example.com")
  end
  let(:subject) { described_class.new(configuration) }

  describe "#notify" do
    it "accumulates the notifications" do
      error = double
      subject.notify(error)
      expect(subject.instance_exec { @output }).to eq([error])
    end
  end

  describe "#finalize" do
    before do
      subject.finalize
    end

    it { is_expected.to have_sent_email }
    it { is_expected.to have_sent_email.from("from@example.com") }
    it { is_expected.to have_sent_email.to("to@example.com") }
    it { is_expected.to have_sent_email.with_subject("ValidationErrorReporter") }
    it { is_expected.to have_sent_email.with_body("") }
  end
end
