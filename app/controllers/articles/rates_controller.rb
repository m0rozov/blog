# frozen_string_literal: true

class Articles::RatesController < ArticlesController
  def create
    result = RateContext.create_rate_and_return_avg_article_rates(
      resource_articles,
      rate_params
    )

    case result
    when Dry::Monads::Success
      respond_with_200()
    when Dry::Monads::Failure
      respond_with_422(result.failure)
    end
  end

  protected

  def rate_params
    params.require(:rate_params).permit(:rate) if params[:rate_params].present?
  end
end