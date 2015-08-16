require "json_api_errors/templates"
require "json_api_errors/templates/default"
require "forwardable"

# JsonApiErrors::Error
# ====================
#
# An error object that by default conforms to the JsonAPI error spec.
# See: http://jsonapi.org/format/#errors
#
# When you initialize a new instance of JsonApiErrors::Error without any
# arguments, you receive an error object with default values. The defaults
# only serve to demonstrate what an error following the entire spec looks like.
# Other than that they are not helpful because it's difficult to know exactly
# what a default error means. So you need to configure the error you wish to generate.
#
# There are two parts to configuring an error object:
#
# TODO: I've overhauled the mechanism for creating error objects. I've opted to
# inject error templates into the error object. The initializer no longer takes
# an implicit block. I need to document this change.


module JsonApiErrors
  class Error

    extend Forwardable

    attr_accessor :template

    def initialize(template: JsonApiErrors::Templates::Default.new)
      @template = template
    end

    def call
      template.render
    end

    def status_code
      template.status
    end
  end
end
