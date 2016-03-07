class CommitsTicket < ActiveRecord::Base
  belongs_to :commit
  belongs_to :ticket
end
