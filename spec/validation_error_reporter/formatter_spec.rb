require "spec_helper"

describe ValidationErrorReporter::Formatter do

  describe "#output(message)" do
    it "outpus a formatted message" do
      expect($stdout).to receive(:puts)
      subject.output("message")
    end
  end

end
