class GithubHookParser::Commit

  attr_reader :raw

  def initialize(raw)
    @raw = raw.with_indifferent_access
  end

  def remote_id
    lookup_key 'id'
  end

  def url
    lookup_key 'url'
  end

  def message
    lookup_key 'message'
  end

  def referenced_commits
    message.scan /[\da-f]{40}/
  end

  def tickets
    pivotal_tickets | myaccount_jira_tickets
  end

  def attributes
    {
      remote_id: remote_id,
      url: url,
      message: message,
    }
  end

  private

  def pivotal_tickets
    GithubHookParser::PivotalTicket.from_message message
  end

  def myaccount_jira_tickets
    GithubHookParser::MyaccountTicket.from_message message
  end

  def lookup_key(key)
    raw.fetch(key)
  end
end
