class ProjectOwner < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true

  before_destroy :projects_empty?

  private

  def projects_empty?
    projects.empty?
  end
end
