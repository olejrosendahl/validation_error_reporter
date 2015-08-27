module ValidationErrorReporter
  class Runner

    def self.run(options = {})
      Rails.application.eager_load!
      models = models_for(options[:models])

      run_validations(models, Reporter.new)
    end

    private

    def self.models_for(model_names = [])
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

    def self.run_validations(models, reporter)
      models.each do |model|
        errors = []
        model.find_each do |record|
          errors << Error.new(record) unless record.valid?
        end
        reporter.report(errors)
      end
    end

  end
end
