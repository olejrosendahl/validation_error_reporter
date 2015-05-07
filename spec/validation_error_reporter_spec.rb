require "spec_helper"

describe ValidationErrorReporter::Runner do

  describe ".run(options = {})" do
    include Mail::Matchers

    before do
      Mail::TestMailer.deliveries.clear
    end

    describe "when model doesn't exist" do
      it "is given an error" do
        expect {
          described_class.run(print: true, models: "Shop")
        }.to raise_error(ArgumentError, "Chosen model 'Shop' does not exist")
      end
    end

    describe "with email options" do
      before do
        described_class.run(
          email_to: "ole.johnny.rosendahl@gmail.com",
          email_from: "show-model-errors@example.com"
        )
      end

      it { should have_sent_email }
      it { should have_sent_email.to("ole.johnny.rosendahl@gmail.com") }
      it { should have_sent_email.from("show-model-errors@example.com") }
      it { should have_sent_email.with_subject("ShowModelError: Report") }
    end

    describe "with print only option" do
      before do
        described_class.run(print: true)
      end

      it { should_not have_sent_email }
    end
  end

end
