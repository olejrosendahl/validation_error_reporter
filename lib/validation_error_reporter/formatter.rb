module ValidationErrorReporter
  class Formatter

    def initialize
      @output = $stdout
    end

    def output(message)
      @output.puts message
      @output.flush
    end

  end
end
