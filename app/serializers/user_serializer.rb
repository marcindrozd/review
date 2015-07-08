class UserSerializer < ApplicationSerializer
  attributes :id, :email, :image_url, :nickname, :name, :admin, :person_id, :token
  has_many :roles

  private

  def admin
    object.has_role? :admin
  end

  def token
    object.tokens.first.try(:value)
  end
end
