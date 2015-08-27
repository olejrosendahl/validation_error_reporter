module ValidationErrorReporter
  class Notifier

    def initialize
      @formatter = Formatter.new
    end

    def notify(message)
      @formatter.output(message)
    end
  end
end
