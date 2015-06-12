class GithubHookParser::PivotalTicket
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
    'pivotal'
  end

  def url
    AppConfig.ticket_trackers.pivotal_story_url + ticket_id
  end

  def self.from_message(message)
    message.scan(/#(\d+)/).flatten.map { |ticket_id| new ticket_id }
  end
end
