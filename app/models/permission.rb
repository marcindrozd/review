class Permission < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user, :project, presence: true
  validates :user, uniqueness: {scope: :project}
end
