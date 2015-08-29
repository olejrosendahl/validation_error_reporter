module ValidationErrorReporter
  module Notifiers
    class Email
      attr_reader :output, :configuration

      def initialize(configuration)
        @configuration = configuration
        @output = []
      end

      def notify(error)
        @output << error
      end

      def finalize
        from = @configuration.from
        to = @configuration.to
        body = output.join("\n")
        Mail.deliver do
          from from
          to to
          subject "ValidationErrorReporter"
          body body
        end
      end
    end
  end
end
