module ValidationErrorReporter
  class PlaintextFormatter

    attr_accessor :errors

    def initialize(errors)
      @errors = errors
    end

    def format
      [rows, footer].join("\n")
    end

    private

    def rows
      errors.collect do |error|
        "#{error[0]} #{error[1]}:\n" + error[2].map {|e| "  #{e}"}.join("\n")
      end.join("\n")
    end

    def footer
      "Total Errors: #{number_of_errors}"
    end

    def number_of_errors
      counter = 0
      errors.each do |error|
        counter += error[2].size
      end
      counter
    end
  end
end
