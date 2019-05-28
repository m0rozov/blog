# frozen_string_literal: true

module Articles
  module Rates
    class CreateCommand < ApplicationCommand
      def call(article, rate_params)
        rate = article.rates.new
        rate.attributes = rate_params
        Articles::Rates::CreateValidator.check(rate).bind do |new_rate|
          rate.save!
          Success(rate)
        end
      end
    end
  end
end
