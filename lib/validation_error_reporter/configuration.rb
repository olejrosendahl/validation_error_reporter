module ValidationErrorReporter

  class Configuration
    attr_accessor :to, :from, :profiler, :notifiers

    def initialize(options = {})
      @to = options.delete(:to)
      @from = options.delete(:from)

      @notifiers = []
      @notifiers << Notifiers::Console.new(self)
      @notifiers << Notifiers::Email.new(self) if @to && @from
    end
  end

end
