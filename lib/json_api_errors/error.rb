require "json_api_errors/default/id"
require "json_api_errors/default/code"
require "json_api_errors/default/status"
require "json_api_errors/default/title"
require "json_api_errors/default/detail"
require "json_api_errors/default/links"
require "json_api_errors/default/source"
require "json_api_errors/default/meta"
require "json_api_errors/default/error"

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

    attr_accessor :error, :id, :status, :links, :code, :title, :detail,
                  :source, :meta

    def initialize( error:  JsonApiErrors::Default::Error.new,
                    id:     JsonApiErrors::Default::Id.new,
                    status: JsonApiErrors::Default::Status.new,
                    code:   JsonApiErrors::Default::Code.new,
                    links:  JsonApiErrors::Default::Links.new,
                    title:  JsonApiErrors::Default::Title.new,
                    detail: JsonApiErrors::Default::Detail.new,
                    source: JsonApiErrors::Default::Source.new,
                    meta:   JsonApiErrors::Default::Meta.new )

      @error   = error
      @id      = id
      @status  = status
      @code    = code
      @links   = links
      @title   = title
      @detail  = detail
      @source  = source
      @meta    = meta

      yield(self) if block_given?
    end

    def call
      error.call(self)
    end

    def status_code
      status.to_s
    end
  end
end
