# frozen_string_literal: true

module Articles
  class CreateValidator < ApplicationValidator
    validates :title, :text, :ip, presence: true
    validates :user, presence: true
    validates :ip, format: { with: /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/ }


    def user
      @entity&.user
    end
  end
end