module ValidationErrorReporter

  class ErrorReport
    attr_accessor :records, :formatter, :lut

    def initialize(records, formatter)
      @records, @formatter, @lut = records, formatter, {}
    end

    def generate
      formatter.output(rows + "\n\n" + summary)
    end

    private

    def rows
      records.collect do |record|
        next if record.valid?

        collect_stats(record)
        formatter.format_record(record)
      end.compact.join("\n")
    end

    def collect_stats(record)
      key = record.class.model_name.name
      if lut[key]
        lut[key][:count] += 1
      else
        lut[key] = {
          count: 1,
          total: record.class.count,
        }
      end
    end

    def summary
      return "" if lut.keys.length <= 1

      "Summary:\n" + most_errors_text + "\n" + highest_error_rate_text
    end

    def most_errors
      lut.sort_by { |_,hash| -hash[:count] }.first
    end

    def most_errors_text
      "Model with most errors: #{most_errors[0]}" +
        " (#{most_errors[1][:total]} entries, #{most_errors[1][:count]} error(s))."
    end

    def highest_error_rate
      lut.each_value do |hash|
        hash[:rate] = hash[:count].to_f / hash[:total].to_f * 100
      end.sort_by { |_,hash| -hash[:rate] }.first
    end

    def highest_error_rate_text
      "Model with highest error rate: #{highest_error_rate[0]}" +
        " (#{highest_error_rate[1][:total]} entries, #{highest_error_rate[1][:count]} error(s), #{highest_error_rate[1][:rate]}%)."
    end

  end
end
