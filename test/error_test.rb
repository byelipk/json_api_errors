require "test_helper"

class JsonApiErrors::ErrorTest < Minitest::Test
  def test_it_exists
    assert JsonApiErrors::Error
  end

  # test "it implements the #call interface" do
  #   error = JsonApiErrors::Error.new
  #   assert_respond_to error, :call
  # end
  #
  # test "it calls an error hash" do
  #   error  = JsonApiErrors::Error.new
  #   result = error.call
  #   keys   = %i[ id status code links title detail source meta ]
  #
  #   keys.each do |key|
  #     assert_includes result.keys, key, "#{key} was not included in #{result.keys}"
  #   end
  # end
  #
  # test "it implements the #status_code interface" do
  #   error = JsonApiErrors::Error.new
  #   assert_respond_to error, :status_code
  #   assert_equal "422", error.status_code
  # end
  #
  # test "it can be injected with a non-default error object" do
  #   class NonDefaultError
  #     def call(error)
  #       {
  #         title:  error.title.to_s,
  #         detail: error.detail.to_s,
  #         meta:   error.meta.to_h
  #       }
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( error: NonDefaultError.new )
  #   result = error.call
  #   keys   = %i[ detail title meta ]
  #
  #   keys.each do |key|
  #     assert_includes result.keys, key, "#{key} was not included in #{result.keys}"
  #   end
  # end
  #
  # test "it can be injected with a non-default id object" do
  #   class NonDefaultId
  #     def to_s
  #       "non-default-id"
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( id: NonDefaultId.new )
  #   assert_equal "non-default-id", error.id.to_s
  # end
  #
  # test "it can be injected with a non-default status object" do
  #   class NonDefaultStatus
  #     def to_s
  #       "non-default-status"
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( status: NonDefaultStatus.new )
  #   assert_equal "non-default-status", error.status.to_s
  # end
  #
  # test "it can be injected with a non-default code object" do
  #   class NonDefaultCode
  #     def to_s
  #       "non-default-code"
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( code: NonDefaultCode.new )
  #   assert_equal "non-default-code", error.code.to_s
  # end
  #
  # test "it can be injected with a non-default links object" do
  #   class NonDefaultLinks
  #     def to_h
  #       {
  #         about: "non-default-links"
  #       }
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( links: NonDefaultLinks.new )
  #   assert_equal "non-default-links", error.links.to_h[:about]
  # end
  #
  # test "it can be injected with a non-default title object" do
  #   class NonDefaultTitle
  #     def to_s
  #       "non-default-title"
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( title: NonDefaultTitle.new )
  #   assert_equal "non-default-title", error.title.to_s
  # end
  #
  # test "it can be injected with a non-default detail object" do
  #   class NonDefaultDetail
  #     def to_s
  #       "non-default-detail"
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( detail: NonDefaultDetail.new )
  #   assert_equal "non-default-detail", error.detail.to_s
  # end
  #
  # test "it can be injected with a non-default source object" do
  #   class NonDefaultSource
  #     def to_h
  #       {
  #         pointer: "non-default-pointer",
  #         parameter: "non-default-parameter"
  #       }
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( source: NonDefaultSource.new )
  #   assert_equal "non-default-pointer", error.source.to_h[:pointer]
  #   assert_equal "non-default-parameter", error.source.to_h[:parameter]
  # end
  #
  # test "it can be injected with a non-default meta object" do
  #   class NonDefaultMeta
  #     def to_h
  #       {
  #         some_extra_extra_info: "non-default-meta",
  #       }
  #     end
  #   end
  #
  #   error  = JsonApiErrors::Error.new( meta: NonDefaultMeta.new )
  #   assert_equal "non-default-meta", error.meta.to_h[:some_extra_extra_info]
  # end
  #
  # test "it can take a block" do
  #   error = JsonApiErrors::Error.new do |config|
  #     config.id     = "1"
  #     config.links  = { about: "http://ruby-doc.org/core-2.2.2/Proc.html" }
  #     config.status = "500"
  #     config.code   = "Internal Server Error"
  #     config.title  = "WTF!"
  #     config.detail = "Not a clue"
  #     config.source = { pointer: "/data/attributes/aha" }
  #     config.meta   = { about: "How about that block?" }
  #   end
  #
  #   assert_equal "1", error.id
  #   assert_equal({ about: "http://ruby-doc.org/core-2.2.2/Proc.html" }, error.links)
  #   assert_equal "500", error.status
  #   assert_equal "Internal Server Error", error.code
  #   assert_equal "WTF!", error.title
  #   assert_equal "Not a clue", error.detail
  #   assert_equal({ pointer: "/data/attributes/aha" }, error.source)
  #   assert_equal({ about: "How about that block?" }, error.meta)
  # end
  #
  # test "it can configure the template via the block" do
  #   class NonDefaultError
  #     def call(error)
  #       {
  #         title:  error.title.to_s,
  #         detail: error.detail.to_s,
  #         meta:   error.meta.to_h
  #       }
  #     end
  #   end
  #
  #   error = JsonApiErrors::Error.new do |config|
  #     config.error  = NonDefaultError.new
  #     config.title  = "My title"
  #     config.detail = "My details"
  #     config.meta   = { about: "My hash" }
  #   end
  #
  #   error_hash = error.call
  #
  #   error_keys = %i[ title detail meta ]
  #
  #   error_keys.each do |key|
  #     assert_includes error_hash.keys, key
  #   end
  #
  #   expected_hash = {:title=>"My title", :detail=>"My details", :meta=>{:about=>"My hash"}}
  #   assert_equal expected_hash, error_hash
  # end
  #
  # test "it can take a proc for a template" do
  #   template = ->(error) do
  #     {
  #       code: error.code.to_s,
  #       status: error.status.to_s
  #     }
  #   end
  #
  #   error = JsonApiErrors::Error.new do |config|
  #     config.error  = template
  #     config.code   = "my-error-code"
  #     config.status = "400"
  #   end
  #
  #   error_hash = error.call
  #
  #   assert_equal "my-error-code", error_hash[:code]
  #   assert_equal "400", error_hash[:status]
  #   assert_equal({:code=>"my-error-code", :status=>"400"}, error_hash)
  # end
end
