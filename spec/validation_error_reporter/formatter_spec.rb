require "spec_helper"

module ValidationErrorReporter
  describe Formatter do

    describe "#format(message)" do
      it "outpus a formatted message" do
        expect(subject.format(:message)).to eq(:message)
      end
    end

  end
end
