class Commit < ActiveRecord::Base
  SOON_TO_EXPIRE = 6.hours
  AUTOREJECT_TIME = 48.hours

  before_create :get_associated_project, :set_expires_at
  belongs_to :project
  belongs_to :author, class_name: 'Person'
  has_and_belongs_to_many :tickets

  scope :stale_pending,  ->{ pending.where{created_at.lteq AUTOREJECT_TIME.ago} }
  scope :stale_passed,   ->{ passed.where{passed_at.lteq AUTOREJECT_TIME.ago} }
  scope :soon_to_expire, ->{ pending.where{expires_at.lt SOON_TO_EXPIRE.from_now} }
  scope :by_expire_date, ->{ order(:expires_at) }
  scope :with_author,    ->{ joins(:author).group("people.email") }

  scope :for_state, ->(state){ where(state: state) }
  [:accepted, :pending, :rejected, :passed, :auto_rejected, :fixed].each do |state|
    scope state, ->{ for_state state.to_s }
  end

  state_machine :state, :initial => :pending do

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
      transition :pending => :auto_rejected
    end

    event :fix do
      transition [:passed, :rejected] => :fixed
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
    self.tickets << ticket
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
      "not_reviewed"    => (pending + auto_rejected).size,
      "passed"          => passed.count,
      "soon_to_expire"  => pending.soon_to_expire.count,
      "auto_rejected"   => auto_rejected.count,
      "rejected"        => (rejected + auto_rejected).size,
    }
  end

  def check_outdate
    auto_reject! if outdated?
  end

  def outdated?
    Time.now > expires_at
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
    if url.present? and (parts = url.split('/'))[4].present?
      self.project = Project.find_or_create_by(name: parts[4])
    end
  end

  def set_expires_at
    self.expires_at = AUTOREJECT_TIME.from_now
  end
end
