namespace :validation_error_reporter do

  desc "Print or email validation error report"
  task :validate => :environment do
    options                = {}
    options[:models]       = ENV["MODELS"].split(",") if ENV["MODELS"]
    options[:email_to]     = ENV["EMAIL_TO"]
    options[:email_from]   = ENV["EMAIL_FROM"]

    ValidationErrorReporter::Runner.run(options)
  end

end
