class Ticket < ActiveRecord::Base
  has_and_belongs_to_many :commits

end
