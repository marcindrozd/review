class GithubHookParser::Repository

  attr_reader :raw

  def initialize(raw)
    @raw = raw.with_indifferent_access
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

end

