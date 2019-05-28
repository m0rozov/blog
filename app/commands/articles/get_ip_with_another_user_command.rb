# frozen_string_literal: true

module Articles
  class GetIpWithAnotherUserCommand < ApplicationCommand
    def call
      ip_with_users_array = Article.joins(:user)
                                   .select(:ip, 'array_agg(DISTINCT users.login)')
                                   .group('ip')
                                   .having('COUNT(DISTINCT user_id) > 1')
                                   .pluck(:ip, 'array_agg(DISTINCT users.login)')
      Success(ip_with_users_array)
    end
  end
end
