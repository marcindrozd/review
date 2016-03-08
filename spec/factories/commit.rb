FactoryGirl.define do
  factory :commit do
    message Faker::Lorem.sentence

    trait :with_project do
      project
    end

    factory :pending_commit do
      state 'pending'
    end

    factory :accepted_commit  do
      state 'accepted'
    end
  end
end

