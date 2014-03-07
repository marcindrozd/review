class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :image_url, :nickname, :name, :admin, :person_id
  has_many :permissions
end
