class ProjectOwner < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true

  before_destroy :ensure_no_projects

  private

  def ensure_no_projects
    projects.empty?
  end
end
