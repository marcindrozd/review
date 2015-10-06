FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "project#{n}" }
    sequence(:url) { |n| "http://url#{n}.com" }
  end
end
