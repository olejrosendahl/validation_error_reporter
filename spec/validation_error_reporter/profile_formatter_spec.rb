require "spec_helper"

module ValidationErrorReporter
  describe ProfileFormatter do
    let(:profile) {{
      "Project" => { count: 1, total: 1, rate: 100.0 }
    }}

    describe "#format(profile)" do
      it "creates a summary string from the given hash" do
        expect(subject.format(profile)).to eq(
          "Summary:\n" +
          "Model with most errors: Project (1 entries, 1 errors, 100.0%).\n" +
          "Model with highest error rate: Project (1 entries, 1 errors, 100.0%)."
        )
      end

      describe "when profile is empty" do
        it "returns 'No errors'" do
          expect(subject.format({})).to eq("No errors")
        end
      end
    end
  end
end
