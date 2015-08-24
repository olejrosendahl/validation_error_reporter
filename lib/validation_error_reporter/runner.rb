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
          !model.public_methods.include?(:all) || model.abstract_class? ||
            !model.table_exists? ||  model.name.include?("HABTM_")
        end
      end

    end

    def run(options = {})
      Rails.application.eager_load!

      models = Entity.from_models(options[:models])
      formatted_text = generate_report(find_invalid_records(models))

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

    def find_invalid_records(models)
      invalid_records = []
      models.each do |model|
        model.all.find_each { |record| invalid_records << record unless record.valid? }
      end
      invalid_records
    end

    def generate_report(invalid_records)
      ErrorReport.new(invalid_records, PlaintextFormatter.new).generate
    end
  end
end
