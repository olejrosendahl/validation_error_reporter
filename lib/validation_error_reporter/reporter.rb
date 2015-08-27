module ValidationErrorReporter

  class Reporter
    attr_reader :notifiers

    def initialize
      @notifiers = []
      @notifiers << Notifier.new
    end

    def report(errors)
      errors.each do |error|
        notifiers.each do |notifier|
          notifier.notify(error.to_s)
        end
      end
    end

  end
end
