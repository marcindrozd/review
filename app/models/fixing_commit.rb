class FixingCommit < ActiveRecord::Base
  validates :fixing_commit_id, presence: true
  validates :fixed_commit_id,  presence: true
end
