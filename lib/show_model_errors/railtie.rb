module ShowModelErrors
  class Railtie < Rails::Railtie
    rake_tasks do
      load "show_model_errors/tasks.rake"
    end
  end
end
