class GithubHookParser::Person

  def initialize(raw)
    @raw = raw.with_indifferent_access
  end

  def attributes
    {
      username: username,
      email: email,
      name: name,
    }
  end

  def username
    @raw.fetch('username')
  end

  def email
    @raw.fetch('email')
  end

  def name
    @raw.fetch('name')
  end

end

