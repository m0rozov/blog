require 'rails_helper'

describe Articles::TopCommand do
  before(:all) do
    @top_articles         = Articles::TopCommand.new.call(articles_count: 100)
    @count_articles       = Article.count
    @max_avg_rate_article = @top_articles.success.first
  end

  it "should return Failure(Count of top Articles don\'t present) if article not valid" do
    res = Articles::TopCommand.new.call(articles_count: 'test')

    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? 'Count of top Articles don\'t valid'
  end

  it "should return success but result count less then articles_count params" do
    res = Articles::TopCommand.new.call(articles_count: @count_articles + 100)

    expect(res.success?).to be true
    expect(res.success.count).equal? @count_articles
    expect(res.success.count).not_to eq(@count_articles + 100)
    expect(res.success.first).equal? @max_avg_rate_article
  end

  it "should return Success articles if articles_count valid" do
    res = Articles::TopCommand.new.call(articles_count: @count_articles)

    expect(res.success?).to be true
    expect(res.success.count).equal? @count_articles
    expect(res.success.first).equal? @max_avg_rate_article
  end
end