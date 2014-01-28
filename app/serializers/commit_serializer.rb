class CommitSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :remote_id, :message, :state, :remote_url
  has_one :project
  has_many :tickets

  def remote_url
    object.url
  end
end
