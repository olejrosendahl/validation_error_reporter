require "spec_helper"

module ValidationErrorReporter
  describe Configuration do

    it { is_expected.to respond_to(:to) }
    it { is_expected.to respond_to(:from) }
    it { is_expected.to respond_to(:profiler) }
    it { is_expected.to respond_to(:notifiers) }

    describe "initialize(options)" do
      it "profiles by default" do
        expect(subject.profiler).to be_instance_of(Profiler)
      end

      context "when not options present" do
        it "adds a console notifer to notifiers" do
          expect(subject.notifiers.first).to be_an_instance_of Notifiers::Console
        end
      end

      context "when 'to' and 'from' is present" do
        let(:subject) { described_class.new(from: "from", to: "to") }

        it "adds a email notifier to notifiers" do
          expect(subject.notifiers.last).to be_an_instance_of Notifiers::Email
        end
      end
    end
  end
end
