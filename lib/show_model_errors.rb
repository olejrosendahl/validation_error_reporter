require "show_model_errors/version"
require "show_model_errors/plaintext_formatter"
require "show_model_errors/error_finder"
require "show_model_errors/options_validator"
require "show_model_errors/model_resolver"
require "show_model_errors/runner"

require "rails"
require "active_record"
require "show_model_errors/railtie" if defined? Rails
require "mail"

Mail.defaults do
  delivery_method :sendmail
end
