namespace :show_model_errors do

  desc "Show errors on all models"
  task :validate => :environment do
    options                = {}
    options[:models]       = ENV["MODELS"]

    ShowModelErrors::Runner.run(options)
  end

end
