# frozen_string_literal: true
module Api
  module V1
    module Articles
      class RatesController < ApplicationController
        def create
          result = RateContext.create_rate_and_return_avg_article_rates(
            resource_articles,
            rate_params
          )

          case result
          when Dry::Monads::Success
            respond_with_200(::Articles::Rates::ShowAvgRepresenter.new.call(result.success))
          when Dry::Monads::Failure
            respond_with_422(result.failure.source)
          end
        end

        protected

        def rate_params
          if params[:rate_params].present?
            params.require(:rate_params).permit(:rate)
          end
        end

        def resource_articles
          @resource_articles ||=  if params[:article_id].present?
                                    Article.find_by(id: params[:article_id])
                                  end
        end
      end
    end
  end
end