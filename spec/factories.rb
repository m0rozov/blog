FactoryBot.define do

  factory :user do
    login { Faker::Name.unique.first_name }
  end

  factory :article do
    user
    title { Faker::Book.title }
    text  { Faker::Lorem.paragraph }
    ip    { Faker::Internet.unique.ip_v4_address }
  end
end