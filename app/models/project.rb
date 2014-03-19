class Project < ActiveRecord::Base
  KINDS = %w( internal global none )

  has_many :commits
  has_many :permissions
  has_many :tokens, as: :tokenable

  validates :name,  uniqueness: true, presence: true
  validates :url,   uniqueness: true
  validates :token, uniqueness: true
  validates :trade_details, inclusion: { in: KINDS }, allow_nil: true


  def deadline
    first_commit.expires_at
  end

  def first_commit
    commits.by_expire_date.first || Commit.new(expires_at: nil)
  end
end
