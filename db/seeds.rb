ip_array = Array.new(50) do
  Faker::Internet.unique.ip_v4_address
end

100.times do
  User.create(login: Faker::Name.unique.first_name)
end

200_000.times do
  ArticleContext.create_article(
    User.find(Random.new.rand(1..100)),
    {
      title: Faker::Book.title,
      text:  Faker::Lorem.paragraph
    },
    ip_array.sample
  )
end

100_000.times do
  Articles::Rates::CreateCommand.new.call(
    Article.find(Random.new.rand(1..200_000)),
    { rate: Random.new.rand(1..5) }
  )
end
