require "spec_helper"

module ValidationErrorReporter
  describe Reporter do

    let(:configuration) { Configuration.new }
    let(:subject) { described_class.new(configuration) }

    describe "initialize(configration)" do
      it "assigns notifiers from the configuration" do
        expect(subject.notifiers).to eq(configuration.notifiers)
        expect(subject.profiler).to eq(configuration.profiler)
      end
    end

    describe "#report(error)" do
      it "sends all the failed records to the notifiers" do
        error = double(:to_s)

        expect(error).to receive(:to_s).exactly(1).times
        expect_any_instance_of(Notifiers::Console).to receive(:notify).exactly(1).times

        subject.report(error)
      end
    end

    describe "#finalize" do
      it "finalizes all notifiers" do
        notifier = double
        configuration = Configuration.new
        configuration.notifiers = [notifier]

        reporter = described_class.new(configuration)

        expect(notifier).to receive(:notify).exactly(1).times
        expect(notifier).to receive(:finalize).exactly(1).times
        reporter.finalize
      end
    end
  end
end
