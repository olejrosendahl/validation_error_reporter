module ValidationErrorReporter
  class Runner
    attr_reader :options, :models

    def initialize(options = {})
      @options = options
    end

    def run
      Rails.application.eager_load!
      @models = Entity.models_for(options[:models])

      configuration = Configuration.new(options)
      run_validations(models, Reporter.new(configuration))
    end

    private

    def run_validations(models, reporter)
      models.each do |model|
        model.find_each do |record|
          reporter.report(Error.new(record)) unless record.valid?
        end
      end
      reporter.finalize
    end

  end
end
