# frozen_string_literal: true

module Articles
  # Command for create Articles
  class CreateCommand < ApplicationCommand
    def call(user, article_params, ip)
      return Failure('User not found') unless user.present?

      article = user.articles.new
      article.attributes = article_params
      article.ip = ip

      Articles::CreateValidator.check(article).bind do |new_article|
        new_article.save!
        Success(new_article)
      end
    end
  end
end
