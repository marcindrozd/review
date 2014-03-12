class CommitSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :remote_id, :message, :state, :remote_url, :expires_at, :created_at, :authored_at
  has_one :project
  has_one :author
  has_many :tickets
  has_many  :fixing_commits, class_name: 'CommitFix', foreign_key: 'fixed_commit_id'
  has_many  :fixed_commits,  class_name: 'CommitFix', foreign_key: 'fixing_commit_id'

  def remote_url
    object.url
  end
end
