FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "project#{n}" }
    sequence(:url) { |n| "http://url#{n}.com" }

    trait :with_project_owner do
      project_owner
    end

    trait :with_role do
      after :create do |project|
        create(:role, :project_role, :with_user, project: project)
      end
    end

    trait :with_commit_fix do
      after :create do |project|
        create(:commit_fix, :with_commits, project: project)
      end
    end

    trait :with_ticket do
      after :create do |project|
        create(:ticket, :with_commits, project: project)
      end
    end

    factory :project_with_all_associations,
            traits: [:with_project_owner, :with_commit_fix, :with_ticket, :with_role]
  end
end
