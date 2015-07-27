class Invitation < ActiveRecord::Base
  serialize :project_ids
  validates :email, presence: true
  before_create :generate_token
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([email, sender_id, Time.now, rand].join)
  end
end
