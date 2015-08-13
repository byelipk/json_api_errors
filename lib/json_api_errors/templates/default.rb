module JsonApiErrors
  module Templates
    class Default
      def call
        {
          id:     id,
          status: status,
          code:   code,
          links:  links,
          title:  title,
          detail: detail,
          source: source,
          meta:   meta
        }
      end

      def id
        "default-id"
      end

      def status
        "default_status"
      end

      def code
        "default-code"
      end

      def links
        {
          about: "default-links"
        }
      end

      def title
        "default-title"
      end

      def detail
        "default_detail"
      end

      def source
        {
          pointer: "default-pointer",
          parameter: "default-parameter"
        }
      end

      def meta
        {
          meta: "default-meta"
        }
      end
    end
  end
end
