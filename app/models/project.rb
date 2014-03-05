class Project < ActiveRecord::Base
  has_many :commits
  has_many :permissions

  validates :name,  uniqueness: true, presence: true
  validates :url,   uniqueness: true
  validates :token, uniqueness: true

  before_create :generate_token!
  scope :from_token, ->(token){ where(token: token) }

  def deadline
    first_commit.expires_at
  end

  def first_commit
    commits.by_expire_date.first || Commit.new(expires_at: nil)
  end

  private

  def generate_token!
    begin
      self.token = SecureRandom.hex
    end while self.class.from_token(self.token).exists?
  end
end
