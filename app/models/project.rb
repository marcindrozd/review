class Project < ActiveRecord::Base
  has_many :commits
  has_many :permissions

  validates :name,  uniqueness: true
  validates :token, uniqueness: true, presence: true

  after_initialize :generate_token!

private
  def generate_token!
    begin
      self.token = SecureRandom.hex
    end while self.class.where(token: self.token).present?
  end
end
