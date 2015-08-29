module ValidationErrorReporter
  class Reporter
    attr_reader :notifiers, :profiler

    def initialize(configuration)
      @notifiers = configuration.notifiers
      @profiler = configuration.profiler if configuration.profiler
    end

    def report(errors)
      errors.each do |error|
        notifiers.each do |notifier|
          notifier.notify(error.to_s)
        end
      end

      if profiler
        profile = profiler.profile(errors)
        notifiers.each { |notifier| notifier.notify(profile.to_s) }
      end

      notifiers.each(&:finalize)
    end

  end
end
