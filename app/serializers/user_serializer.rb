class UserSerializer < ApplicationSerializer
  attributes :id, :email, :nickname, :name, :admin, :person_id, :token, :image_url
  has_many :roles

  private

  def admin
    object.has_role? :admin
  end

  def token
    object.tokens.first.try(:value)
  end
  def image_url
    "https://avatars.githubusercontent.com/u/#{object.remote_uid}"
  end
end
