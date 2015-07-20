# DefaultSource
# =============
#
# This is the default error source. To override this you can create your own
# class that implements #to_hash and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(source: MySpecialErrorSourceClass.new)
#
# From the api docs:
#
# an object containing references to the source of the error, optionally
# including any of the following members:
#
# pointer: a JSON Pointer [RFC6901] to the associated entity in the
#          request document [e.g. "/data" for a primary data object,
#          or "/data/attributes/title" for a specific attribute].
#
# parameter: a string indicating which query parameter caused the error.
module JsonApiErrors
  module Default
    class Source
      def to_h
        {
          pointer: "default-pointer",
          parameter: "default-parameter"
        }
      end
    end
  end
end
