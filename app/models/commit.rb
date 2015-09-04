class Commit < ActiveRecord::Base
  SOON_TO_EXPIRE = 2
  AUTOREJECT_TIME = 48

  before_create :get_associated_project, :set_expires_at
  after_create :get_associated_commits, :fix_commits

  scope :stale_pending,  ->{ pending.where('created_at <= ?', AUTOREJECT_TIME.business_hours.ago) }
  scope :stale_passed,   ->{ passed.where('passed_at <= ?', AUTOREJECT_TIME.business_hours.ago) }
  scope :soon_to_expire, ->{ pending.where('expires_at < ?', SOON_TO_EXPIRE.business_hours.from_now) }
  scope :by_expire_date, ->{ order(:expires_at) }
  scope :by_remote,      ->(remote) { where(remote_id: remote) }
  scope :with_author,    ->{ joins(:author).group("people.email") }
  scope :for_state,      ->(state) { where(state: state) }
  scope :to_auto_reject, -> { where(state: :pending) }
  scope :to_reject, -> { where(state: :passed) }
  scope :unreviewed,     -> { where(state: %w(pending auto_rejected)) }
  scope :order_by_priority, -> { order(order_by_state) }
  [:accepted, :pending, :rejected, :passed, :auto_rejected, :fixed].each do |state|
    scope state, -> { for_state state.to_s }
  end
  scope :tagged, ->(tag){ tag.present? ? tagged_with(tag) : all }

  has_many :fixing_commits, class_name: 'CommitFix', foreign_key: 'fixed_commit_id'
  has_many :fixed_commits,  class_name: 'CommitFix', foreign_key: 'fixing_commit_id'
  has_many :fixes, class_name: 'Commit', through: :fixing_commits
  has_many :fixed, class_name: 'Commit', through: :fixed_commits

  belongs_to :project
  belongs_to :author, class_name: 'Person'
  belongs_to :reviewer, class_name: 'User'

  has_and_belongs_to_many :tickets
  acts_as_taggable
  acts_as_taggable_on :languages

  state_machine :state, initial: :pending do

    event :accept do
      transition all - :accepted => :accepted
    end

    event :pass do
      transition all - :passed => :passed
    end

    event :reject do
      transition all - :rejected => :rejected
    end

    event :auto_reject do
      transition [:pending, :passed] => :auto_rejected
    end

    event :fix do
      transition all => :fixed
    end

    after_transition any => :passed do |commit, _transition|
      commit.update_attribute(:expires_at, AUTOREJECT_TIME.business_hours.from_now)
    end
  end

  def self.add_remote(remote_commit)
    unless where(remote_id: remote_commit.remote_id).exists?
      create(remote_commit.attributes) do |commit|
        commit.add_remote_tickets remote_commit.tickets
        commit.set_commit_author remote_commit.author
      end
    end
  end

  def self.order_by_state
    statement = "CASE"
    [:rejected, :auto_rejected, :passed, :pending].each_with_index do |state, i|
      statement << " WHEN state = '#{state}' THEN #{i}"
    end
    statement << " END"
  end

  def attempt_transition_to(state)
    self.state_event = external_transitions.fetch(state) { "undefined transition" }
  end

  def add_remote_tickets(tickets)
    tickets.each { |ticket| add_remote_ticket ticket }
  end

  def set_commit_author(author)
    self.author = Person.find_or_create_by author.attributes
  end

  def add_remote_ticket(remote_ticket)
    ticket = Ticket.where(remote_id: remote_ticket.ticket_id, source: remote_ticket.ticket_type).first
    ticket ||= Ticket.create remote_ticket.attributes
    tickets << ticket
  end

  def self.add_batch_remote(commits)
    commits.map{ |commit| add_remote commit }.compact
  end

  def self.by_user_hash
    with_author.count
  end

  def self.by_state_hash
    {
      "pending"         => pending.count,
      "not_reviewed"    => unreviewed.size,
      "passed"          => passed.count,
      "soon_to_expire"  => pending.soon_to_expire.count,
      "auto_rejected"   => auto_rejected.count,
      "rejected"        => (rejected + auto_rejected).size,
    }
  end

  def overdue_actions
    return unless outdated?
    pending? ? auto_reject! : reject!
  end

  def outdated?
    Time.now > expires_at
  end

  def fixes_data
    { remoteId: remote_id, url: url }
  end

  private

  def external_transitions
    {
      "accepted" => "accept",
      "passed" => "pass",
      "rejected" => "reject",
      "auto_rejected" => "auto_reject",
      "fixed" => "fix",
    }
  end

  def get_associated_project
    if url.present? && (parts = url.split('/'))[4].present?
      self.project = Project.find_or_create_by(name: parts[4])
    end
  end

  def set_expires_at
    self.expires_at = AUTOREJECT_TIME.business_hours.from_now
  end

  def get_associated_commits
    commit_list.each do |fc|
      fc.fixing_commits.create(fixing_commit_id: id)
    end
  end

  def fix_commits
    commit_list.each(&:fix)
  end

  def commit_list
    message.scan(/[\da-f]{40}/).map{ |x| Commit.by_remote(x) }.flatten
  end
end
