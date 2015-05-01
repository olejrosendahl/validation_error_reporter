require "show_model_errors/version"
require "show_model_errors/plaintext_formatter"
require "rails"
require "active_record"
require "show_model_errors/railtie" if defined? Rails
require "mail"

Mail.defaults do
  delivery_method :sendmail
end

module ShowModelErrors
  class Runner

    class << self

      def get_models(models = nil)
        existing_models = ActiveRecord::Base.descendants

        return existing_models unless models.present?

        models.split(',').collect do |class_name|
          unless const_defined?(class_name) || existing_models.include?(class_name)
            puts("Chosen model '#{class_name}' does not exist")
            exit(1)
          end

          class_name.classify.constantize
        end
      end

      def run(options = {})
        Rails.application.eager_load!

        models = get_models(options[:models])
        formatted_text = format(get_errors(models))

        unless options[:email_to] == nil
          Mail.deliver do
            to options[:email_to]
            from "show-model-errors@example.com"
            subject "ShowModelError: Report"
            body formatted_text
          end
        else
          puts formatted_text
        end
      end

      def get_errors(models)
        errors = []
        models.collect do |model|
          next unless ActiveRecord::Base.connection.table_exists? model.table_name
          model.all.collect do |row|
            unless row.valid?
              errors << [model.model_name.human, row.public_send(model.primary_key), row.errors.full_messages]
            end
          end
        end
        errors
      end

      def format(errors)
        PlaintextFormatter.format(errors)
      end
    end

  end
end
