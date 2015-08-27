module ValidationErrorReporter
  class Error
    attr_reader :record

    def initialize(record)
      @record = record
    end

    def to_s
      "#{record.class.model_name.human} #{record.public_send(record.class.primary_key)}:\n" +
        record.errors.full_messages.map {|e| "  #{e}"}.join("\n")
    end
  end
end
