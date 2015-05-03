require "spec_helper"

describe ShowModelErrors::Runner do

  describe ".run(options = {})" do
    include Mail::Matchers

    before do
      Mail::TestMailer.deliveries.clear
    end

    describe "when 'email_to' or 'email_from' is missing" do
      it "throws errors for missing parameters" do
        expect {
          described_class.run(email_to: "you@example.com")
        }.to raise_error(ArgumentError, "Missing required option 'mail_from'")
        expect {
          described_class.run(email_from: "me@example.com")
        }.to raise_error(ArgumentError, "Missing required option 'mail_to'")
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

  describe ".get_errors(models)" do
    it "returns no errors on valid models" do
      Bank.create(name: "World Bank")
      expect(described_class.get_errors([Bank])).to eq([])
    end

    it "returns errors on invalid models" do
      test_bank_2 = Bank.new
      test_bank_2.save(validate: false)
      test_bank_2.valid?
      expect(described_class.get_errors([Bank])).to eq([[test_bank_2.class.model_name.human,
                                 test_bank_2.id, test_bank_2.errors.full_messages]])
    end

    it "throws errors if one of the models doesn't exsit" do
      expect {
        described_class.get_error([Shop])
      }.to raise_error(NameError)
    end
  end
end
