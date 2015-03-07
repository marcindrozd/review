class StateType < ActiveRecord::Base
  validates :name, length: { maximum: 255 }, uniqueness: true
end
