module ValidationErrorReporter
  class Reporter
    attr_reader :notifiers, :profiler, :errors

    def initialize(configuration)
      @notifiers = configuration.notifiers
      @profiler = configuration.profiler if configuration.profiler
      @errors = []
    end

    def report(error)
      @errors << error
      notifiers.each { |notifier| notifier.notify(error.to_s) }
    end

    def finalize
      if profiler
        profile = profiler.profile(errors)
        formatter = ProfileFormatter.new
        notifiers.each { |notifier| notifier.notify(formatter.format(profile)) }
      end

      notifiers.each(&:finalize)
    end

  end
end
