# DefaultDetail
# =============
#
# This is the default error detail. To override this you can create your own
# class that implements #to_s and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(detail: MySpecialErrorDetailClass.new)
#
# From the api docs:
#
# a human-readable explanation specific to this occurrence of the problem.
module JsonApiErrors
  module Default
    class Detail
      def to_s
        "default-detail"
      end
    end
  end
end
