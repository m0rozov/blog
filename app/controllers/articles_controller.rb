class ArticlesController < ApplicationController
  def create
    result = ArticleContext.create_article(resource_user, article_params, request.remote_ip)

    case result
    when Dry::Monads::Success
      respond_with_200(Articles::ShowRepresenter.new.call(result.success))
    when Dry::Monads::Failure
      respond_with_422(result.failure)
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
    @resource_user = if params[:login].present?
                       User.find_by(login: params[:login])
                     else
                       User.new(login: params[:login])
                     end
  end

  def resource_articles
    @resource_articles ||= params[:id].present? ? Article.find_by(id: params[:id]) : nil
  end
end