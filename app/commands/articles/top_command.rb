
# frozen_string_literal: true

module Articles
  class TopCommand < ApplicationCommand
    def call(articles_count: nil)
      unless articles_count.present? && articles_count.class == Integer
        return Failure(Blog::ValidationError.new('Count of top Articles don\'t valid'))
      end

      top_articles = Article.order('CASE
                                      WHEN rate_count = 0 THEN 0
                                      WHEN rate_count > 0 THEN cast(rate_sum as float) / rate_count
                                    END DESC ').limit(articles_count)

      Success(top_articles)
    end
  end
end
