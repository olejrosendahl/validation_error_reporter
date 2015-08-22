require "spec_helper"

describe ValidationErrorReporter::ErrorReport do

  def create_record(name)
    bank = Project.new(name: name)
    bank.save(validate: false)
    bank.valid?
    bank
  end

  let(:records) { [create_record("F"), create_record("Second")] }
  let(:subject) do
    described_class.new(records)
  end

  describe "#records" do
    it "retruns a list of records with errors" do
      expect(subject.records).to eq(records)
    end
  end
end
