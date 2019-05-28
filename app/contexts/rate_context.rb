module RateContext
  class << self
    def create_rate_and_return_avg_article_rates(article, rate_params)
      Articles::Rates::CreateCommand.new.call(article, rate_params).bind do |rate|
        Articles::AvgRateCommand.new.call(article)
      end
    end
  end
end
