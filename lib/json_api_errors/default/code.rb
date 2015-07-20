# DefaultCode
# ===========
#
# This is the default error code. To override this you can create your own
# class that implements #to_s and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(status: MySpecialErrorCodeClass.new)
#
# From the api docs:
#
# an application-specific error code, expressed as a string value.
module JsonApiErrors
  module Default
    class Code
      def to_s
        "default-code"
      end
    end
  end
end
