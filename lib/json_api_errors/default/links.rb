# DefaultLinks
# ============
#
# This is the default error links. To override this you can create your own
# class that implements #to_hash and inject it into the constructor
# like this:
#
# JsonAPI::Error.new(links: MySpecialErrorLinksClass.new)
#
# From the api docs:
#
# a links object containing the following members:
#
# about: a link that leads to further details about this particular
#        occurrence of the problem.
module JsonApiErrors
  module Default
    class Links
      def to_h
        {
          about: "default-links"
        }
      end
    end
  end
end
