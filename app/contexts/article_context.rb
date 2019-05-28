module ArticleContext
  class << self
    def create_article(user, article_params)
      Articles::CreateCommand.new.call(user, article_params)
    end
  end
end
