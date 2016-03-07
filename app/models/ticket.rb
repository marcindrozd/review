class Ticket < ActiveRecord::Base
  has_many :commits_tickets
  has_many :commits, through: :commits_tickets
end
