class GithubHookParser::Repository

  attr_reader :raw

  def initialize(raw)
    @raw = raw.with_indifferent_access
  end

  def owner
    parse_owner
  end

  def owner_raw
    lookup_key 'owner'
  end

  def attributes
    {
      name: name,
      url: url,
    }
  end

  def name
    @raw.fetch('name')
  end

  def url
    @raw.fetch('url')
  end

  private

  def lookup_key(key)
    raw.fetch(key)
  end

  def parse_owner
    GithubHookParser::ProjectOwner.new owner_raw
  end

end

