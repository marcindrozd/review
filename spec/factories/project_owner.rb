FactoryGirl.define do
  factory :project_owner do
    name Faker::name
    email Faker::Internet.email
  end
end
