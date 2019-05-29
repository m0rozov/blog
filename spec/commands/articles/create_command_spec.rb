require 'rails_helper'

describe Articles::CreateCommand do

  before(:all) do
    @user = create(:user)
    @ip   = Faker::Internet.unique.ip_v4_address
  end

  it "should return Failure(User not found) if user nil" do
    res = Articles::CreateCommand.new.call(nil, { title: Faker::Book.title,
                                                  text: Faker::Lorem.paragraph},
                                                  @ip)
      expect(res.failure?).to be true
      expect(res.failure).equal? 'User not found'
  end

  it "should return Failure(Blog::ValidationError) if article params emty" do
    res = Articles::CreateCommand.new.call(@user, {}, @ip)
    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? "{:title=>['can\'t be blank'], :text=>['can\'t be blank']}"
  end

  it "should return Failure(Blog::ValidationError) if article ip emty" do
    res = Articles::CreateCommand.new.call(@user,
                                           { title: Faker::Book.title, text: Faker::Lorem.paragraph},
                                           nil)
    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? '{:ip=>["can\'t be blank", "is invalid"]}'
  end

  it "should return Failure(Blog::ValidationError) if article ip not valid" do
    res = Articles::CreateCommand.new.call(@user,
                                           { title: Faker::Book.title, text: Faker::Lorem.paragraph},
                                           '123123123')
    expect(res.failure?).to be true
    expect(res.failure.class).to be Blog::ValidationError
    expect(res.failure.source).equal? '{:ip=>["can\'t be blank", "is invalid"]}'
  end

  it "should create article if params are valid" do
    before_article_count = Article.count
    res = Articles::CreateCommand.new.call(@user,
                                           { title: Faker::Book.title, text: Faker::Lorem.paragraph},
                                           @ip)
    expect(res.success?).to be true
    expect(res.value!.class).to be Article
    expect(Article.count).to be before_article_count + 1
  end
end