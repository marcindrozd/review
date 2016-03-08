FactoryGirl.define do
  factory :ticket do
    remote_id Faker::Number.number(10)
    url { "https://www.pivotaltracker.com/story/show/#{remote_id}" }
    source 'pivotal'

    trait :with_commits do
      transient do
        project { create(:project) }
      end

      commits { create_list(:commit, 2, project: project) }
    end
  end
end
