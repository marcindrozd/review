FactoryGirl.define do
  factory :role do
    trait :project_role do
      transient do
        project { create(:project) }
      end

      name 'fake_role'
      resource_type 'Project'
      resource_id { project.id }
    end

    trait :with_user do
      users { [create(:user)] }
    end
  end
end
