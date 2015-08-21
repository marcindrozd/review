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

  def added_files
    lookup_key 'added'
  end

  def modified_files
    lookup_key 'modified'
  end

  def message
    lookup_key 'message'
  end

  def author_raw
    lookup_key 'author'
  end

  def authored_at
    lookup_key 'timestamp'
  end

  def referenced_commits
    message.scan /[\da-f]{40}/
  end

  def tickets
    pivotal_tickets
  end

  def author
    parse_author
  end

  def attributes
    {
      remote_id: remote_id,
      url: url,
      message: message,
      authored_at: authored_at,
    }
  end

  def file_extenssions
    all_files = self.added_files + self.modified_files
    all_files.map do |file|
      file.slice!(/[^.]*$/)
    end.uniq
  end

  private

  def parse_author
    GithubHookParser::Person.new author_raw
  end

  def pivotal_tickets
    GithubHookParser::PivotalTicket.from_message message
  end

  def lookup_key(key)
    raw.fetch(key)
  end
end
