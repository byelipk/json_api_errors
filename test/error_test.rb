require "test_helper"

class JsonApiErrors::ErrorTest < Minitest::Test
  def test_it_exists
    assert JsonApiErrors::Error
  end

  def test_it_implements_call
    error = JsonApiErrors::Error.new
    assert_respond_to error, :call
  end

  def test_it_returns_an_error_hash
    error  = JsonApiErrors::Error.new
    result = error.call
    keys   = %i[ id status code links title detail source meta ]

    keys.each do |key|
      assert_includes result.keys, key
    end
  end

  def test_it_knows_the_status_code
    error = JsonApiErrors::Error.new
    assert_respond_to error, :status_code
    assert_equal "default_status", error.status_code
  end
end
