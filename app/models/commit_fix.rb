class CommitFix < ActiveRecord::Base
  validates :fixing_commit_id, presence: true
  validates :fixed_commit_id,  presence: true

  belongs_to :fixed_commit,  class_name: 'Commit', inverse_of: :fixing_commits
  belongs_to :fixing_commit, class_name: 'Commit', inverse_of: :fixed_commits
  belongs_to :fixes, class_name: "Commit", foreign_key: "fixing_commit_id"
  belongs_to :fixed, class_name: "Commit", foreign_key: "fixed_commit_id"
end
