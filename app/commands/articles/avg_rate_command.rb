# frozen_string_literal: true

module Articles
  class AvgRateCommand < ApplicationCommand
    def call(article)
      return Failure('Not submitted article') unless article.present?

      avg_rate = Article::Rate.joins(:article)
                              .where('articles.id = :id', id: article.id)
                              .average("article_rates.rate")
      Success(avg_rate)
    end
  end
end