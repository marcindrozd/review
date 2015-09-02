class PersonSerializer < ApplicationSerializer
  attributes :id, :username, :name, :image_url

  def image_url
    Gravatar.new(object.email).image_url
  end
end
