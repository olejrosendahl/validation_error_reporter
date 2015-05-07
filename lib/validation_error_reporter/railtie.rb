module ValidationErrorReporter
  class Railtie < Rails::Railtie
    rake_tasks do
      load "validation_error_reporter/tasks.rake"
    end
  end
end
