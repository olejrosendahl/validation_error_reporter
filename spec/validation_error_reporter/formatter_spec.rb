require "spec_helper"

describe ValidationErrorReporter::Formatter do

  describe "#format(message)" do
    it "outpus a formatted message" do
      expect(subject.format(:message)).to eq(:message)
    end
  end

end
