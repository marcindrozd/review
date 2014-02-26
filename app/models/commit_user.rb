class CommitUser < ActiveRecord::Base
  has_many :commits
end
