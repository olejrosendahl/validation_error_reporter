# ValidationErrorReporter

Data migrations and multiple changes in model validations over time sometimes leaves the models in an erroneous state and might cause problems if not deteced.

It's unfortunate that one would sometimes need such a tool, but here it is.

Run the task periodically to ensure the data is intact.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validation_error_reporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validation_error_reporter

## Usage

The reports gets creates by a rake task. Printing or emailing the report is
controlled by options sent through environment variables.

To print the report, just run the task without any options:

    $ bundle exec rake validation_error_reporter:validate

To email the report set the `EMAIL_TO` and `EMAIL_FROM` options:

    $ bundle exec rake validation_error_reporter:validate EMAIL_TO=me@example.com
    EMAIL_FROM=you@example.com

If you want to validate specific models you can explicity say which
models you want to validate with the `MODELS` option:

    $ bundle exec rake validation_error_reporter:validate MODELS="Company,
    Subscription"

## Contributing

1. Fork it ( https://github.com/olejrosendahl/validation_error_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

