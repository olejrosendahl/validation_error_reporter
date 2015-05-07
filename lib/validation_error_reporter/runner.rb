module ValidationErrorReporter
  class Runner
    class << self

      def run(options = {})
        Rails.application.eager_load!

        ValidationErrorReporter::OptionsValidator.validate!(options)

        models = get_models(options[:models])
        formatted_text = format(get_errors(models))

        if options[:print] == true
          puts formatted_text
        else
          Mail.deliver do
            to options[:email_to]
            from options[:email_from]
            subject "ShowModelError: Report"
            body formatted_text
          end
        end
      end

      private

      def get_models(models = nil)
        ModelResolver.resolve(models)
      end

      def get_errors(models)
        ErrorFinder.get_errors(models)
      end

      def format(errors)
        PlaintextFormatter.format(errors)
      end
    end
  end
end
