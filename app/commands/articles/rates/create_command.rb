# frozen_string_literal: true

module Articles
  module Rates
    class CreateCommand < ApplicationCommand
      def call(article, rate_params)
        return Failure(Blog::ValidationError.new('Not valid article')) unless article.present? && article.class == Article
        return Failure(Blog::ValidationError.new('Not valid rate'))    unless rate_params.present? && rate_params["rate"].to_i > 0

        rate = article.rates.new
        rate.attributes = rate_params
        Articles::Rates::CreateValidator.check(rate).bind do |new_rate|
          ActiveRecord::Base.transaction do
            new_rate.save!
            article.update_columns(rate_sum:   article.rate_sum + new_rate.rate,
                                   rate_count: article.rate_count + 1)
          end
          Success(new_rate)
        end
      end
    end
  end
end
