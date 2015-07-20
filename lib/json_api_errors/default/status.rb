# DefaultStatus
# =============
#
# This is the default error status code. To override this you can create your own
# class that implements #to_s and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(status: MySpecialErrorStatusClass.new)
#
# From the api docs:
#
# the HTTP status code applicable to this problem, expressed as a string value.
module JsonApiErrors
  module Default
    class Status
      def to_s
        "422"
      end
    end
  end
end
