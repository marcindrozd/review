class GithubHookParser::Ticket

  attr_reader :ticket_id

  def initialize(ticket_id)
    @ticket_id = ticket_id
  end

  def attributes
    {
      remote_id: ticket_id,
      source: ticket_type,
      url: url,
    }
  end

  def ticket_type
    implement_this!
  end

  def url
    implement_this!
  end

  def self.from_message(message)
    implement_this!
  end

  private

  def implement_this!
    raise "implement in child class"
  end
end

