class GithubHookParser::Repository

  def initialize(raw)
    @raw = raw
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

