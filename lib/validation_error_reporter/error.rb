module ValidationErrorReporter
  class Error
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def model_name
      record.class.model_name.name
    end

    def model_total_count
      record.class.count
    end

    def to_s
      "#{record.class.model_name.human} #{record.public_send(record.class.primary_key)}:\n" +
        record.errors.full_messages.map {|e| "  #{e}"}.join("\n")
    end
  end
end
