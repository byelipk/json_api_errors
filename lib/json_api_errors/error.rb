require "json_api_errors/default/id"
require "json_api_errors/default/code"
require "json_api_errors/default/status"
require "json_api_errors/default/title"
require "json_api_errors/default/detail"
require "json_api_errors/default/links"
require "json_api_errors/default/source"
require "json_api_errors/default/meta"
require "json_api_errors/default/error"

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
