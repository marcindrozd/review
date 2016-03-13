class CommitSerializer < ApplicationSerializer
  attributes :id, :remote_id, :message, :state, :remote_url, :expires_at, :created_at, :authored_at,
    :fixed_by, :fixes_for, :tag, :reviewer_id
  has_one :project
  has_one :author
  has_many :tickets
  has_many :fixes, include: true, root: :commits
  has_many :fixed, include: true, root: :commits

  def remote_url
    object.url
  end

  def fixed_by
    object.fixes.map { |commit| commit.fixes_data }
  end

  def fixes_for
     object.fixed.map { |commit| commit.fixes_data }
  end
  def tag
    object.tags.map { |o| o.name }
  end
end
