FactoryGirl.define do
  factory :commit do
    message Faker::Lorem.sentence
    project

    factory :pending_commit do
      state 'pending'
    end

    factory :accepted_commit  do
      state 'accepted'
    end
  end
end

