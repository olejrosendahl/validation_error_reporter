module ValidationErrorReporter
  class PlaintextFormatter

    def output(text)
      text
    end

    def format_record(record, options = {})
      "#{record.class.model_name.human} #{record.public_send(record.class.primary_key)}:\n" +
        record.errors.full_messages.map {|e| "  #{e}"}.join("\n")
    end

  end
end
