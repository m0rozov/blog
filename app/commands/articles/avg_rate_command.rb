# frozen_string_literal: true

module Articles
  class AvgRateCommand < ApplicationCommand
    def call(article)
      unless article.present? && article.class == Article
        return Failure(Blog::ValidationError.new('Not valid article'))
      end

      return Success(0) if article.rate_sum.zero?

      sql = "SELECT cast(rate_sum as float) / rate_count as avg_rate
             FROM articles
             WHERE rate_sum > 0 AND rate_count > 0 AND id = #{article.id}"
      result = Article.connection.exec_query(sql)

      Success(result[0] && result[0]["avg_rate"])
    end
  end
end