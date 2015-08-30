require "validation_error_reporter/version"
require "rails"
require "active_record"
require "validation_error_reporter/railtie" if defined? Rails
require "mail"

require "validation_error_reporter/notifiers/console"
require "validation_error_reporter/notifiers/email"
require "validation_error_reporter/entity"

module ValidationErrorReporter
  autoload :Runner, "validation_error_reporter/runner"
  autoload :Formatter, "validation_error_reporter/formatter"
  autoload :Reporter, "validation_error_reporter/reporter"
  autoload :Profiler, "validation_error_reporter/profiler"
  autoload :Error, "validation_error_reporter/error"
  autoload :ProfileFormatter, "validation_error_reporter/profile_formatter"
  autoload :Configuration, "validation_error_reporter/configuration"
end

Mail.defaults do
  delivery_method :sendmail
end
