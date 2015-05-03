namespace :show_model_errors do

  desc "Show errors on all models"
  task :validate => :environment do
    options                = {}
    options[:models]       = ENV["MODELS"]
    options[:email_to]     = ENV["EMAIL_TO"]

    ShowModelErrors::Runner.new.run(options)
  end

end
