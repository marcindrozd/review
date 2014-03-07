class User < ActiveRecord::Base
  has_many :permissions
  belongs_to :person
  before_create :assign_person

  private
  def assign_person
    self.person = Person.find_by(email: self.email)
  end
end
