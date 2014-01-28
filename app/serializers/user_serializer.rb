class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :image_url, :nickname, :name, :admin
  has_many :permissions
end
