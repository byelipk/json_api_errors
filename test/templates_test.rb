require "test_helper"

class JsonApiErrors::TemplatesTest < Minitest::Test
  def test_it_exists
    assert JsonApiErrors::Templates
  end

  def test_it_implements_render
    template = JsonApiErrors::Templates::Default.new
    assert_respond_to template, :render
  end

  def test_it_renders_an_error_template
    skip
    template = JsonApiErrors::Templates::Default.new

    expected = {
      id:     "default-id",
      status: "default-status",
      code:   "default-code",
      links:  {
        about: "default-links"
      },
      title:  "default-title",
      detail: "default-detail",
      source: {
        pointer: "default-pointer",
        parameter: "default-parameter"
      },
      meta: {
        about: "default-meta"
      }
    }

    assert_equal expected, template.render
  end
end
