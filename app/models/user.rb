class User < ActiveRecord::Base
  extend FriendlyId
  rolify
  friendly_id :nickname
  has_many :tokens, as: :tokenable
  has_one :invitation, foreign_key: 'recipient_id'
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'

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
