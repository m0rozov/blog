# frozen_string_literal: true

module Blog
  class BaseError < StandardError
  end

  class ValidationError < Blog::BaseError
    attr_reader :source

    def initialize(source)
      @source = source

      super('Validation failed')
    end

    def inspect
      "#<#{self.class.name}: #{source}>"
    end
  end
end
