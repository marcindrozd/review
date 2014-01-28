class Project < ActiveRecord::Base
  has_many :commits
  has_many :permissions
  validates :name, uniqueness: true
end
