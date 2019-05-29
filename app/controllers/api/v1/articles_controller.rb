module Api
  module V1
    class ArticlesController < ApplicationController
      def create
        result = ArticleContext.create_article(resource_user, article_params, user_ip)

        case result
        when Dry::Monads::Success
          respond_with_200(Articles::ShowRepresenter.new.call(result.success))
        when Dry::Monads::Failure
          respond_with_422(result.failure.source)
        end
      end

      def top_articles
        result = ArticleContext.get_top_articles(params[:top_count])

        case result
        when Dry::Monads::Success
          respond_with_200(Articles::TopRepresenter.new.call(result.success))
        when Dry::Monads::Failure
          respond_with_422(result.failure.source)
        end
      end

      def articles_with_same_ip_different_user
        result = ArticleContext.get_articles_with_same_ip_different_user

        case result
        when Dry::Monads::Success
          respond_with_200(Articles::IpWithLoginsRepresenter.new.call(result.success))
        when Dry::Monads::Failure
          respond_with_422(result.failure.source)
        end
      end

      protected

      def article_params
        if params[:article_params].present?
          params.require(:article_params).permit(
            :title,
            :text
          )
        end
      end

      def resource_user
        if params[:login].present?
          @resource_user ||= User.find_by(login: params[:login]) || User.new(login: params[:login])
        end
      end

      def user_ip
        if Rails.env.production?
          request.remote_ip
        else
          '127.0.0.1'
        end
      end
    end
  end
end