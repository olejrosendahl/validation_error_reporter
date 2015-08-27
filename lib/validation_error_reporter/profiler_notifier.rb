module ValidationErrorReporter
  class ProfilerNotifier < Notifier
    attr_reader :buffer

    def initialize
      @buffer = []
    end

    def notify(error)
      buffer << error
    end
  end

end
