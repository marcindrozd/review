class GithubHookParser::MyaccountTicket < GithubHookParser::Ticket

  def ticket_type
    'myacc'
  end

  def url
    AppConfig.ticket_trackers.myacc_jira_story_url + ticket_id
  end

  def self.from_message(message)
    message.scan(/MYACC-\d+/).map { |ticket_id| new ticket_id }
  end
end
