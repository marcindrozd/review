class UserSerializer < ApplicationSerializer
  attributes :id, :image_url, :nickname, :name, :admin, :person_id, :token
  has_many :permissions

  private

  def token
    object.tokens.first.try(:value)
  end
end
