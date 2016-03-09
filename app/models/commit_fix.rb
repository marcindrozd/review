class CommitFix < ActiveRecord::Base
  before_destroy :ensure_project_consistency

  validate :ensure_project_consistency
  validates :fixing_commit_id, presence: true
  validates :fixed_commit_id,  presence: true

  belongs_to :fixed_commit,  class_name: 'Commit', inverse_of: :fixing_commits
  belongs_to :fixing_commit, class_name: 'Commit', inverse_of: :fixed_commits
  belongs_to :fixes, class_name: "Commit", foreign_key: "fixing_commit_id"
  belongs_to :fixed, class_name: "Commit", foreign_key: "fixed_commit_id"

  private

  def ensure_project_consistency
    if fixed_commit.project != fixing_commit.project
      errors[:base] << 'Commit from one project fixed commit from another project!'
      false
    end
  end
end
