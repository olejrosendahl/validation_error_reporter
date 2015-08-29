require "spec_helper"

describe ValidationErrorReporter::Profiler do

  describe "#profile" do
    it "outputs a string with stats" do
      record = double(class: double(count: 2, model_name: double(name: "Project")))
      error = ValidationErrorReporter::Error.new(record)

      expect(subject.profile([error])).to eq(
        "Summary:\n" +
        "Model with most errors: Project (2 entries, 1 errors, 50.0%).\n" +
        "Model with highest error rate: Project (2 entries, 1 errors, 50.0%)."
      )
    end
  end

end
