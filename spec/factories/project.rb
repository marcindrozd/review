FactoryGirl.define do
  factory :project do
    name Faker::Lorem.word
    url Faker::Internet.url
  end
end
