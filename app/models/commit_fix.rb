class CommitFix < ActiveRecord::Base
  validates :fixing_commit_id, presence: true
  validates :fixed_commit_id,  presence: true

  belongs_to :fixed_commit,  class_name: 'Commit', inverse_of: :fixing_commits
  belongs_to :fixing_commit, class_name: 'Commit', inverse_of: :fixed_commits
end
