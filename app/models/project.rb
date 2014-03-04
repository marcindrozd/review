class Project < ActiveRecord::Base
  has_many :commits
  has_many :permissions

  validates :name,  uniqueness: true, presence: true
  validates :url,   uniqueness: true
  validates :token, uniqueness: true

  before_create :generate_token!
  scope :from_token, ->(token){ where(token: token) }

  def self.create_from_hash remote_repository
    create(remote_repository.attributes)
  end

  def deadline
    first_commit.present? ? first_commit.expires_at : nil
  end

  def first_commit
    commits.by_expire_date.first
  end

private
  def generate_token!
    begin
      self.token = SecureRandom.hex
    end while self.class.from_token(self.token).exists?
  end
end
