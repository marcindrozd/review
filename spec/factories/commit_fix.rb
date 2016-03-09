FactoryGirl.define do
  factory :commit_fix do
    trait :with_commits do
      transient do
        project { create(:project) }
      end

      fixing_commit { create(:commit, :with_project, project: project) }
      fixed_commit { create(:commit, :with_project, project: project) }
    end
  end
end
