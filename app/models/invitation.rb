class Invitation < ActiveRecord::Base
  serialize :project_ids
  validates :email, uniqueness: true, presence: true
  before_create :generate_token
  belongs_to :sender, class_name: 'User', inverse_of: :sent_invitations
  belongs_to :recipient, class_name: 'User', inverse_of: :invitation

  private

  def generate_token
    self.token = SecureRandom.hex(13)
  end
end
