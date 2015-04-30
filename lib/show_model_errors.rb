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
      def run(mail = false)
        Rails.application.eager_load!

        formatted_text = format(get_errors)

        if mail == true
          Mail.deliver do
            to "ole.johnny.rosendahl@gmail.com"
            from "show-model-erros@example.com"
            subject "ShowModelError: Report"
            body formatted_text
          end
        else
          puts formatted_text
        end
      end

      def get_errors
        errors = []
        ActiveRecord::Base.descendants.collect do |model|
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
