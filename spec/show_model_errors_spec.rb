require "spec_helper"

describe ShowModelErrors::Runner do

  describe ".run(options = {})" do
    include Mail::Matchers

    before do
      Mail::TestMailer.deliveries.clear
      described_class.run(mail: true)
    end

    it { should have_sent_email }
    it { should have_sent_email.from("show-model-errors@example.com") }
    it { should have_sent_email.to("ole.johnny.rosendahl@gmail.com") }
    it { should have_sent_email.with_subject("ShowModelError: Report") }
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
  end
end
