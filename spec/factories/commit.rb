FactoryGirl.define do
  factory :commit do
    message Faker::Lorem.sentence
  end

  factory :pending_commit, class: Commit do
    message Faker::Lorem.sentence
    state 'pending'
  end

  factory :accepted_commit, class: Commit  do
    message Faker::Lorem.sentence
    state 'accepted'
  end
end

