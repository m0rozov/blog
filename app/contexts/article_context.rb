module ArticleContext
  class << self
    def create_article(user, article_params, ip)
      Articles::CreateCommand.new.call(user, article_params, ip)
    end

    def get_top_articles(articles_count)
      Articles::TopCommand.new.call(articles_count: articles_count)
    end

    def get_articles_with_same_ip_different_user
      Articles::GetIpWithDifferentUserCommand.new.call
    end
  end
end
