module ValidationErrorReporter

  class ErrorReport
    attr_accessor :records

    def initialize(records = [])
      @records = records
    end

  end
end
