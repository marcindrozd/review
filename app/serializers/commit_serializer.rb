class CommitSerializer < ApplicationSerializer
  attributes :id, :remote_id, :message, :state, :remote_url, :expires_at, :created_at, :authored_at
  has_one :project
  has_one :author
  has_many :tickets
  has_many :fixes, include: true, root: :commits
  has_many :fixed, include: true, root: :commits

  def remote_url
    object.url
  end
end
