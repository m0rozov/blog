require 'rails_helper'

describe Articles::AvgRateCommand do
  before(:all) do
    @article = create(:article)
  end

  it "should return Failure(Not valie article) if article not valid" do
    res = Articles::AvgRateCommand.new.call(create(:user))

    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? 'Not valid article'
  end

  it "should return Success(0) if article present and not have rate" do
    res = Articles::AvgRateCommand.new.call(@article)

    expect(res.success?).to be true
    expect(res.success).equal? 0
    expect(@article.rate_sum).equal? 0
  end

  it "should return Success with avg rate if article present and have rates" do
    rates_array = [Random.new.rand(1..5), Random.new.rand(1..5), Random.new.rand(1..5)]
    rates_array.each do |rate|
      Articles::Rates::CreateCommand.new.call(@article, rate: rate)
    end

    res = Articles::AvgRateCommand.new.call(@article)

    expect(res.success?).to be true
    expect(res.success).equal? @article.rate_sum.to_f / @article.rate_count
    expect(@article.rate_sum).equal? rates_array.sum
    expect(@article.rate_count).equal? rates_array.count
  end
end
