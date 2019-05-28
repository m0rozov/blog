
# frozen_string_literal: true

module Articles
  class TopCommand < ApplicationCommand
    def call(articles_count: nil)
      return Failure('Count of top Articles don\'t present') unless articles_count.present?

      top_articles = Article.joins(:rates)
                            .group('articles.id')
                            .order('AVG(article_rates.rate) DESC')
                            .limit(articles_count)

      Success(top_articles)
    end
  end
end
