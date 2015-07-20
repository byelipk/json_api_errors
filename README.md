# JsonApiErrors

Handling errors gracefully is pretty awesome.

I was having a hard time at that and so one of the steps I took was to create a simple
error object, one that adhered to the JsonAPI Error spec, not coupled to any other
library.

Not all errors need to be handled gracefully, but for those that do its nice to
see a response formatted in a way like it doesn't feel your world is
crashing down (even though it is!):

```json
{
  "errors": [
    {
      "id": "10002",
      "status": "400",
      "links": {
        "about": "www.info-about-the-error.org"
      },
      "code": "Bad Request",
      "title": "Your request didn't have a title attribute.",
      "detail": "Oopps! You'll need to add a title before you can proceed.",
      "source": {
        "pointer": "/data/attribute/title",
        "parameter": "title"
      },
      "meta": {
        "extra_info": "Here's a lollypop!"
      }
    }
  ]
}
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_api_errors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_api_errors

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_api_errors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
