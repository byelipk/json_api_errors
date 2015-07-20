# DefaultMeta
# ===========
#
# This is the default error meta information. To override this you can create your own
# class that implements #to_hash and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(meta: MySpecialErrorMetaClass.new)
#
# From the api docs:
#
# a meta object containing non-standard meta-information about the error.
module JsonApiErrors
  module Default
    class Meta
      def to_h
        {
          extra_info: "default-meta"
        }
      end
    end
  end
end
