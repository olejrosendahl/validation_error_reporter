require "coveralls"
Coveralls.wear!

require "validation_error_reporter"
require "database_cleaner"

Mail.defaults do
  delivery_method :test
end

class ValidationErrorReporterApp < Rails::Application
end


ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :companies do |t|
    t.string :name
  end

  create_table :projects do |t|
    t.string :name
    t.datetime :due
  end
end

class Company < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
end

class Project < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
