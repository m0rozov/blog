module ArticleContext
  class << self
    def create_article(user, article_params, ip)
      Articles::CreateCommand.new.call(user, article_params, ip)
    end
  end
end
