# frozen_string_literal: true

module Articles
  module Rates
    class CreateValidator < ApplicationValidator
      validates :rate, numericality: { only_integer: true,
                                       greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 5 }
      validates :article, presence: true

      def article
        @entity&.article
      end
    end
  end
end