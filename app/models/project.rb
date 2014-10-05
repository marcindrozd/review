class Project < ActiveRecord::Base
  enum trade_details: [:internal, :limited, :global, :no_trade]

  has_many :commits
  has_many :permissions
  has_many :tokens, as: :tokenable
  belongs_to :project_owner

  validates :name,  uniqueness: true, presence: true
  validates :url,   uniqueness: true
  validates :trade_details, presence: true

  after_create :create_token

  def deadline
    first_commit.expires_at
  end

  def first_commit
    commits.by_expire_date.first || Commit.new(expires_at: nil)
  end

  def self.for_user user
    if user.admin?
      get_unreviewed all
    else
      get_unreviewed user.permissions.map(&:project)
    end
  end

  def self.get_unreviewed projects
    projects.select{ |p| p.commits.unreviewed.exists? }
  end

  private

  def create_token
    tokens.create
  end
end
