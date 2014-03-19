class User < ActiveRecord::Base
  has_many :permissions
  has_many :tokens, as: :tokenable

  belongs_to :person
  before_create :assign_person
  after_create :create_token

  private
  def assign_person
    self.person = Person.find_by(email: self.email)
  end

  def create_token
    self.tokens.create
  end
end
