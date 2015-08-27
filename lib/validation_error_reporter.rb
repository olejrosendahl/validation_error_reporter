require "validation_error_reporter/version"
require "rails"
require "active_record"
require "validation_error_reporter/railtie" if defined? Rails
require "mail"

module ValidationErrorReporter
  autoload :Runner, "validation_error_reporter/runner"
  autoload :Formatter, "validation_error_reporter/formatter"
  autoload :Reporter, "validation_error_reporter/reporter"
  autoload :Notifier, "validation_error_reporter/notifier"
  autoload :Error, "validation_error_reporter/error"
end

Mail.defaults do
  delivery_method :sendmail
end
