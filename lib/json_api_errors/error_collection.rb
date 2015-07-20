require 'delegate'

module JsonApiErrors
  class ErrorCollection < DelegateClass(Array)
    def initialize
      super([])
    end

    def add_error(error)
      self << error
    end

    def call
      {
        errors: self.map! { |e| e.call }
      }
    end

    def generic_status
      200
    end
  end
end
