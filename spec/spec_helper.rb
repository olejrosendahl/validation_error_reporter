require "show_model_errors"
require "byebug"

Mail.defaults do
  delivery_method :test
end

class ShowModelErrorsApp < Rails::Application
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :banks do |t|
    t.integer :name
  end
end

class Bank < ActiveRecord::Base
  validates :name, presence: true
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
