require 'test_helper'

class JsonApiErrors::ErrorCollectionTest < Minitest::Test
  def test_it_exists
    assert JsonApiErrors::ErrorCollection
  end

  PUBLIC_API = %i[ add_error call generic_status ]

  PUBLIC_API.each do |method|
    define_method("test_it_responds_to_#{method}") do
      collection = JsonApiErrors::ErrorCollection.new
      assert_respond_to collection, method
    end
  end

  def test_it_adds_an_error_to_itself
    error      = JsonApiErrors::Error.new
    collection = JsonApiErrors::ErrorCollection.new

    collection.add_error(error)

    assert_includes collection, error, "error was not included in the collection"
  end

  def test_it_returns_errors_when_called
    error      = JsonApiErrors::Error.new
    collection = JsonApiErrors::ErrorCollection.new

    collection.add_error(error)

    result = collection.call

    refute_empty result[:errors]
    assert_equal error.call, result[:errors].first
  end

  def test_generic_status_is_200
    collection = JsonApiErrors::ErrorCollection.new
    assert_equal 200, collection.generic_status
  end
end
