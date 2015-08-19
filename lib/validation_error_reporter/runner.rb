require "thread"

module ValidationErrorReporter
  class Runner

    class Entity

      def self.from_models(model_names)
        if model_names.nil?
          ActiveRecord::Base.descendants
        else
          model_names.collect do |model_name|
            model_name.classify.constantize
          end
        end.reject do |model|
          model.abstract_class? || !model.table_exists? ||  model.name.include?("HABTM_") || !model.public_methods.include?(:all)
        end
      end

    end

    def run(options = {})
      Rails.application.eager_load!

      @source_models = Entity.from_models(options[:models])

      formatted_text = format(get_errors(@source_models))

      if options[:email_from] && options[:email_to]
        Mail.deliver do
          to options[:email_to]
          from options[:email_from]
          subject "ShowModelError: Report"
          body formatted_text
        end
      else
        puts formatted_text
      end
    end

    private

    def get_errors(models)
      errors = []
      models.each do |model|
        model.all.find_each do |row|
          unless row.valid?
            errors << [model.model_name.human, row.public_send(model.primary_key), row.errors.full_messages]
          end
        end
      end
      errors
    end

    def format(errors)
      PlaintextFormatter.new(errors).format
    end
  end
end
