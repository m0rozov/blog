require 'rails_helper'

describe Articles::Rates::CreateCommand do

  before(:all) do
    @user    = create(:user)
    @article = create(:article)
  end

  it "should return Failure(Not valie article) if article not valid" do
    res = Articles::Rates::CreateCommand.new.call(@user, rate: 5)

    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? 'Not valid article'
  end

  it "should return Failure(rate must be less or equal 5) if rate more than five" do
    res = Articles::Rates::CreateCommand.new.call(@article, rate: 10)

    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? '{:rate=>["must be less than or equal to 5"]}'
  end

  it "should return Failure(rate must be less or equal 5) if rate less than zero" do
    res = Articles::Rates::CreateCommand.new.call(@article, rate: -2)

    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? '{:rate=>["must be less than or equal to 5"]}'
  end

  it "should create rate if params are valid" do
    before_rates_count = Article::Rate.count
    res = Articles::Rates::CreateCommand.new.call(@article, { "rate" => 5 })

    expect(res.success?).to be true
    expect(res.value!.class).to be Article::Rate
    expect(Article::Rate.count).to be before_rates_count + 1
  end
end