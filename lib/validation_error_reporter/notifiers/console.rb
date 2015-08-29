module ValidationErrorReporter
  module Notifiers
    class Console

      def initialize(configuration)
        @formatter = Formatter.new
      end

      def notify(message)
        @formatter.output(message)
      end

      def finalize
      end

    end
  end
end
