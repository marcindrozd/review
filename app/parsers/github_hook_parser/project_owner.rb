class GithubHookParser::ProjectOwner
  def initialize(raw)
    @raw = raw.with_indifferent_access
  end

  def attributes
    {
      name: name,
      email: email,
    }
  end

  def name
    @raw.fetch('name')
  end

  def email
    @raw.fetch('email')
  end
end
