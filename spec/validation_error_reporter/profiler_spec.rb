require "spec_helper"

module ValidationErrorReporter
  describe Profiler do
    describe "#profile" do
      it "returns a hash with stats" do
        error_1 = double(model_name: "Project", model_total_count: 4)
        error_2 = double(model_name: "Project", model_total_count: 4)

        expect(subject.profile([error_1, error_2])).to eq({
          "Project" => {
            count: 2,
            total: 4,
            rate: 50.0,
          },
        })
      end
    end
  end
end
