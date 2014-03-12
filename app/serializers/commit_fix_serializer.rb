class CommitFixSerializer < ActiveModel::Serializer
  attributes :id, :fixed_commit_id, :fixing_commit_id

  belongs_to :fixed_commit,  class_name: 'Commit', inverse_of: :fixing_commits
  belongs_to :fixing_commit, class_name: 'Commit', inverse_of: :fixed_commits
end
