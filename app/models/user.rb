class User < ActiveRecord::Base
  extend FriendlyId
  rolify
  friendly_id :nickname
  has_many :tokens, as: :tokenable
  has_one :invitation, foreign_key: 'recipient_id', inverse_of: :recipient
  has_many :sent_invitations, class_name: 'Invitation',
    foreign_key: 'sender_id', inverse_of: :sender

  belongs_to :person
  before_create :assign_person
  after_create :create_token

  scope :fuzzy, ->(query) { query.present? ? where("email LIKE ?", "%#{ query }%") : all }

  def permitted_in_project?(project)
    has_role?(:developer) || has_role?(:admin) || has_role?(:contractor, project)
  end

  private

  def assign_person
    self.person = Person.find_by(email: email)
  end

  def create_token
    tokens.create
  end
end
