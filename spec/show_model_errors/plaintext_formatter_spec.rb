require "spec_helper"

describe ShowModelErrors::PlaintextFormatter do

  describe ".format" do
    it "formats the text for email" do
      errors = [["Bank", 1, ["ID is missing", "Something wrong"]], ["Bank", 2, ["Wrong format"]]]

      expect(described_class.format(errors)).to eq(
        "Bank 1:\n" +
        "  ID is missing\n" +
        "  Something wrong\n" +
        "Bank 2:\n" +
         "  Wrong format\n"
      )
    end
  end

end
