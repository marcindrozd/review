FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
  end
  factory :contractor, class: User do
    email Faker::Internet.email
  end
end
