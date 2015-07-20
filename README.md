# JsonApiErrors

Handling errors gracefully is pretty awesome.

I was having a hard time at that and so one of the steps I took was to create a simple
error object, one that adhered to the Json API Error spec, not coupled to any other
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
While it's nice to have an easy way to build errors, this project was mainly an
excuse to play around with object-oriented and functional concepts in Ruby. Because
errors are highly variable, a reusable solution called for using concepts like
dependency injection and composition. The idea of using blocks, callables, and building up the error object naturally came on later.

I hope this is at least of some use to you or that it inspires you to make something even better.


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

So you want an error object? Well, all you need to do is this:

```ruby
  error = JsonApiErrors::Error.new

  #<JsonApiErrors::Error:0x007ff753941ce8
     @code=#<JsonApiErrors::Default::Code:0x007ff7539416a8>,
     @detail=#<JsonApiErrors::Default::Detail:0x007ff7539414c8>,
     @error=#<JsonApiErrors::Default::Error:0x007ff753941c20>,
     @id=#<JsonApiErrors::Default::Id:0x007ff753941b58>,
     @links=#<JsonApiErrors::Default::Links:0x007ff753941680>,
     @meta=#<JsonApiErrors::Default::Meta:0x007ff753941428>,
     @source=#<JsonApiErrors::Default::Source:0x007ff753941478>,
     @status=#<JsonApiErrors::Default::Status:0x007ff753941b30>,
     @title=#<JsonApiErrors::Default::Title:0x007ff753941568>>
```

A `JsonApiError::Error` implements `#call`. So to get a hash representation
of your error, which can be serialized into JSON, you need to send the `#call`
message to your error object:

```ruby
  error.call

  {:id=>"default-id",
   :links=>{:about=>"default-links"},
   :status=>"422",
   :code=>"default-code",
   :title=>"default-title",
   :detail=>"default-detail",
   :source=>{:pointer=>"default-pointer", :parameter=>"default-parameter"},
   :meta=>{:extra_info=>"default-meta"}}
```
All those defaults suck!

Yup. The [Json API spec](http://jsonapi.org/format/#error-objects) says that all those keys and values are OPTIONAL as defined by the RFC [Key words for use in RFCs to Indicate Requirement Levels](http://tools.ietf.org/html/rfc2119). These are all placeholders for the actual keys and values you care about including in your error response. So how do you create and error object that is actually meaningful to your situation?

The easiest way is probably to use a block with literal values to define the
attributes you want to send in your response:

```ruby
  error = JsonApiErrors::Error.new do |config|
    config.id     = "90210"
    config.status = "500"
    config.code   = "your-internal-server-error-app-code"
    config.title  = "Oh my!"
    config.detail = "If I knew what happened I would tell you"
    config.links  = { about: "www.example.com" }
    config.source = { pointer: "data/attributes/hmm", parameter: "hmm" }
    config.meta   = { sunshine: "It feels nice" }
  end

  error.call

  {:id=>"90210",
   :links=>{:about=>"www.example.com"},
   :status=>"500",
   :code=>"your-internal-server-error-app-code",
   :title=>"Oh my!",
   :detail=>"If I knew what happened I would tell you",
   :source=>{:pointer=>"data/attributes/hmm", :parameter=>"hmm"},
   :meta=>{:sunshine=>"It feels nice"}}
```

Now let's say you only want to send back the status and the code attributes:

```ruby
  error = JsonApiErrors::Error.new do |config|
    config.id     = "90210"
    config.status = "500"
  end

  error.call

  {:id=>"90210",
   :links=>{:about=>"default-links"},
   :status=>"500",
   :code=>"default-code",
   :title=>"default-title",
   :detail=>"default-detail",
   :source=>{:pointer=>"default-pointer", :parameter=>"default-parameter"},
   :meta=>{:extra_info=>"default-meta"}}
```

Gross. Let's modify the template the error object uses to generate the hash
representation:

```ruby
  template = ->(error) do
    {
      status: error.status,
      code:   error.code
    }
  end

  error = JsonApiErrors::Error.new do |config|
    config.error  = template
    config.code   = "my-apps-custom-error-code"
    config.status = "500"
  end

  error.call

  {
    :status=>"500",
    :code=>"my-apps-custom-error-code"
  }
```

Nice! We passed in a lambda as a template. I said previously that the `JsonApiErrors::Error` implements `#call`. Well, that method is delegated to
the error template's `#call` method. So instead of a lambda you could have
created a class which implements `#call` and accepts an error object as an
argument and then injected it into the initializer:

```ruby
  class CustomTemplate
    def call(error)
      {
        status: error.status.to_s,
        code:   error.code.to_s
      }
    end
  end

  error = JsonApiErrors::Error.new( error: CustomTemplate.new ) do |config|
    config.code   = "my-apps-custom-error-code"
    config.status = "500"
  end

  error.call

  {
    :status=>"500",
    :code=>"my-apps-custom-error-code"
  }
```
In fact, all the properties of `JsonApiErrors::Error` are available as keyword
arguments, so you could inject all the dependencies into the initializer. Or
just as well use the `config` object in the block to customize everything to
your liking.

Note that certain config options take strings while others take hashes. If you
decide to create a class to represent a particular attribute, you'll need to
override either the `#to_s` or `#to_h`. (This project was built using Ruby 2.2.2)

```ruby
  class CustomLinks
    def to_h
      { about: "www.i-am-hash.com" }
    end
  end

  class CustomTitle
    def to_s
      "i-am-title"
    end
  end
```

The [Json API spec](http://jsonapi.org/format/#error-objects) mentions that all
errors MUST have the keyword `errors` at the root. For this purpose there is
`JsonApiError::ErrorCollection`. To get a fully qualified hash representation
of your error you can:

```ruby
  collection = JsonApiErrors::ErrorCollection.new
  collection.add_error(error)
  collection.call

  {:errors=>[
    {
      :status=>"500",
      :code=>"my-apps-custom-error-code" }]}

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_api_errors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
