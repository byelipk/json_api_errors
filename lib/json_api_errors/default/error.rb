module JsonApiErrors
  module Default
    class Error
      def call(error)
        {
          id:     error.id.to_s,
          links:  error.links.to_h,
          status: error.status.to_s,
          code:   error.code.to_s,
          title:  error.title.to_s,
          detail: error.detail.to_s,
          source: error.source.to_h,
          meta:   error.meta.to_h
        }
      end
    end
  end
end
