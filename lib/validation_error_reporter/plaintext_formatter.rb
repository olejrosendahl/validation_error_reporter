module ValidationErrorReporter
  class PlaintextFormatter
    attr_accessor :report

    def initialize(report)
      @report = report
    end

    def format
      [rows, footer].join("\n")
    end

    private

    def records
      report.records
    end

    def rows
      report.records.collect do |record|
        "#{record.class.model_name.human} #{record.public_send(record.class.primary_key)}:\n" +
          record.errors.full_messages.map {|e| "  #{e}"}.join("\n")
      end.join("\n")
    end

    def footer
      "Total Errors: #{number_of_errors}"
    end

    def number_of_errors
      records.sum { |r| r.errors.size }
    end
  end
end
