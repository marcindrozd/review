class Commit < ActiveRecord::Base
  EXPIRATION = 2.days
  AUTOREJECT_TIME = 48.hours

  before_create :get_associated_project, :set_expires_at
  belongs_to :project
  belongs_to :author, class_name: 'Person'
  has_and_belongs_to_many :tickets

  scope :for_state, ->(state){ where(state: state) }
  [:accepted, :pending, :rejected, :passed, :auto_rejected].each do |state|
    scope state, ->{ for_state state.to_s }
  end

  scope :stale_pending, ->{ pending.where{created_at.lteq EXPIRATION.ago} }
  scope :stale_passed, ->{ passed.where{passed_at.lteq EXPIRATION.ago} }
  scope :not_reviewed, ->{ where{state.eq nil} }
  scope :by_expire_date, ->{ order(:expires_at) }

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
    user = Person.find_or_create_by author.attributes
    self.author = user
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
    joins(:author).group("people.name").count
  end

  def self.by_state_hash
    group("state").count
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
