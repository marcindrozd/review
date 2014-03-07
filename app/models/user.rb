class User < ActiveRecord::Base
  has_many :permissions
  belongs_to :person
end
