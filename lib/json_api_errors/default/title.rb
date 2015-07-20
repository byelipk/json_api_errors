# DefaultTitle
# ============
#
# This is the default error title. To override this you can create your own
# class that implements #to_s and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(title: MySpecialErrorTitleClass.new)
#
# From the api docs:
#
# a short, human-readable summary of the problem that SHOULD NOT change
# from occurrence to occurrence of the problem, except for purposes of
# localization.
module JsonApiErrors
  module Default
    class Title
      def to_s
        "default-title"
      end
    end
  end
end
