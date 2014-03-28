class GithubHookParser::Repository

  attr_reader :raw

  def initialize(raw)
    @raw = raw.with_indifferent_access
  end

  def owner
    @owner ||= GithubHookParser::ProjectOwner.new(owner_raw)
  end

  def attributes
    {
      name: name,
      url: url,
    }
  end

  def name
    lookup_key 'name'
  end

  def url
    lookup_key 'url'
  end

  private

  def lookup_key(key)
    raw.fetch(key)
  end

  def owner_raw
    lookup_key 'owner'
  end
end

