# frozen_string_literal: true

module Articles
  class TopRepresenter
    def call(articles)
      articles.map do |article|
        {
          title:    article.title,
          text:     article.text,
        }
      end
    end
  end
end
