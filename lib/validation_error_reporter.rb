require "validation_error_reporter/version"
require "validation_error_reporter/plaintext_formatter"
require "validation_error_reporter/error_finder"
require "validation_error_reporter/options_validator"
require "validation_error_reporter/model_resolver"
require "validation_error_reporter/error_report"
require "validation_error_reporter/runner"

require "rails"
require "active_record"
require "validation_error_reporter/railtie" if defined? Rails
require "mail"

Mail.defaults do
  delivery_method :sendmail
end
