namespace :show_model_errors do

  desc "Show errors on all models"
  task all: :environment do
    ShowModelErrors::Runner.run(true)
  end

end
