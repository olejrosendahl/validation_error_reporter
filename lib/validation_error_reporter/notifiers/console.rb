module ValidationErrorReporter
  module Notifiers
    class Console
      attr_accessor :formatter, :printer

      def initialize(configuration, printer = $stdout)
        @formatter, @printer = Formatter.new, printer
      end

      def notify(message)
        printer.puts @formatter.format(message)
      end

      def finalize
      end

    end
  end
end
