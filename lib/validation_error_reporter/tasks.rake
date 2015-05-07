namespace :validation_error_reporter do

  desc "Print or email validation error report"
  task :validate => :environment do
    options                = {}
    options[:models]       = ENV["MODELS"]
    options[:email_to]     = ENV["EMAIL_TO"]

    ValidationErrorReporter::Runner.new.run(options)
  end

end
