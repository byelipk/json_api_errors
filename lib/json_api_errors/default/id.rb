# DefaultId
# =========
#
# This is the default error id. To override this you can create your own
# class that implements #to_s and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(id: MySpecialErrorIdClass.new)
#
# From the api docs:
#
# a unique identifier for this particular occurrence of the problem.
module JsonApiErrors
  module Default
    class Id
      def to_s
        "default-id"
      end
    end
  end
end
