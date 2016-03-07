FactoryGirl.define do
  factory :role do
    transient do
      project { create(:project) }
    end

    name 'fake_role'
    resource_type 'Project'
    resource_id { project.id }
    users { [create(:user)] }
  end
end
