class CommitSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :remote_id, :message, :state, :remote_url, :expires_at
  has_one :project
  has_one :author
  has_many :tickets

  def remote_url
    object.url
  end

  def expires_at
    object.expires_at.strftime("%F %l:%M")
  end
end
