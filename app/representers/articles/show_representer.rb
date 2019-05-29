# frozen_string_literal: true

module Articles
  class ShowRepresenter
    def call(article)
      {
        id:       article.id,
        title:    article.title,
        text:     article.text,
        user_id:  article.user_id,
        ip:       article.ip.to_s
      }
    end
  end
end
