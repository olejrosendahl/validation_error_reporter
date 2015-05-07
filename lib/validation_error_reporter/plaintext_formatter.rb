module ValidationErrorReporter
  class PlaintextFormatter

    class << self

      def format(errors)
        errors.collect do |error|
          "#{error[0]} #{error[1]}:\n" + error[2].map {|e| "  #{e}\n"}.join
        end.join
      end

    end


  end
end
