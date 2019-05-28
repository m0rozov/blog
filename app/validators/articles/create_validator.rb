# frozen_string_literal: true

module Articles
  class CreateValidator < ApplicationValidator
    validates :title, :text, :ip, presence: true
    validates :user, presence: true

    def user
      @entity&.user
    end
  end
end
