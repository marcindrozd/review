FactoryGirl.define do
  factory :commit_fix do
    transient do
      project { create(:project) }
    end

    fixing_commit { create(:commit, project: project) }
    fixed_commit { create(:commit, project: project) }
  end
end

