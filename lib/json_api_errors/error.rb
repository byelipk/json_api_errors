require "json_api_errors/template"
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
# First, you'll need to create a template.
#
# Second, you'll need to configure the attributes you want to be displayed
# in the template.
#
# The easiest way to do this is by creating a lambda whose body is a hash
# representing the template you wish to be displayed. Then pass a block to the
# initializer:
#
#       template = ->(error) do
#         {
#           status: error.status,
#           code:   error.code
#         }
#       end
#
#       error = JsonApiErrors::Error.new do |config|
#         config.error  = template
#         config.status = "400"
#         config.code   = "Bad Request"
#       end
#
#       error.call  => { status: "400", code: "Bad Request" }
#
#
# You can also pass in literal values for the attributes for the attributes
# as well as inject them into the initializer:
#
#       JsonApiErrors::Error.new( error:  CustomError.new,
#                                 status: CustomStatus.new,
#                                 code:   CustomCode.new,
#                                 links:  CustomLinks.new )
#
#
#       error.call  => { status: "400",
#                        code: "Bad Request",
#                        links: {
#                          about: "www.example.org"
#                         }
#                       }
#
# Here's how you would define those classes:
#
#      class CustomError
#        def call(error)
#          {
#            status: error.status.to_s,
#            code:   error.code.to_s,
#            links:  error.links.to_h
#          }
#        end
#      end
#
#      class CustomStatus
#        def to_s; "400"; end
#      end
#
#      class CustomCode
#        def to_s; "Bad Request"; end
#      end
#
#      class CustomLinks
#        def to_h; { about: "www.example.com" }; end
#      end
#
# Note:
# =====
# The error class must implement #call and it receives an error object as an argument.
# Classes that define id, status, code, title, detail must implement #to_s.
# Classes that define links, source, and meta must implement #to_h.
#


module JsonApiErrors
  class Error

    extend Forwardable

    attr_accessor :template

    def initialize(template: JsonApiErrors::Template::Default.new)
      @template = template

      yield(self) if block_given?
    end

    def_delegators :template, :id,
                              :status,
                              :code,
                              :links,
                              :title,
                              :detail,
                              :source,
                              :meta

    def call
      template.call
    end

    def status_code
      status.to_s
    end
  end
end
