class GithubHookParser::PivotalTicket < GithubHookParser::Ticket

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
