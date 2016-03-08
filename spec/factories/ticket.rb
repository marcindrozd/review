FactoryGirl.define do
  factory :ticket do
    transient do
      project { create(:project) }
    end

    remote_id Faker::Number.number(10)
    url { "https://www.pivotaltracker.com/story/show/#{remote_id}" }
    source 'pivotal'
    commits { create_list(:commit, 2, project: project) }
  end
end
