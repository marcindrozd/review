class User < ActiveRecord::Base
  extend FriendlyId
  rolify
  friendly_id :nickname
  has_many :tokens, as: :tokenable

  belongs_to :person
  before_create :assign_person
  after_create :create_token

  private

  def assign_person
    self.person = Person.find_by(email: email)
  end

  def create_token
    tokens.create
  end
end
