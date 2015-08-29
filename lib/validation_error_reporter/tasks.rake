namespace :validation_error_reporter do

  desc "Print or email validation error report"
  task :validate => :environment do
    options                = {}
    options[:models]       = ENV["MODELS"].split(",") if ENV["MODELS"]
    options[:from]   = ENV["EMAIL_FROM"]
    options[:to]     = ENV["EMAIL_TO"]

    ValidationErrorReporter::Runner.run(options)
  end

end
