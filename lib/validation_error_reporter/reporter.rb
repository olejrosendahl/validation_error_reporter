module ValidationErrorReporter
  class Reporter
    attr_reader :notifiers, :profiler

    def initialize(profiler = false)
      @notifiers = []
      @notifiers << Notifier.new
      @profiler = profiler ? Profiler.new : profiler
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
    end

  end
end
