class UserSerializer < ApplicationSerializer
  attributes :id, :email, :nickname, :name, :admin, :person_id, :token
  attribute :image_url, :key => :imageUrl
  has_many :roles

  private

  def admin
    object.has_role? :admin
  end

  def token
    object.tokens.first.try(:value)
  end
end
