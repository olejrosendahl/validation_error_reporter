# ValidationErrorReporter

Data migrations and muliple changes in model validations sometimes leaves out
required data leaving the models with errros. It's unfortunate that one should
need such a tool, but here it is. Run the task periodically to ensure the data
is intact.

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

    $ bundle exec rake validation_error_report:validate

To email the report set the `EMAIL_TO` and `EMAIL_FROM` options:

    $ bundle exec rake validation_error_report EMAIL_TO=me@example.com
    EMAIL_FROM=you@example.com

## Contributing

1. Fork it ( https://github.com/[my-github-username]/validation_error_reporter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
