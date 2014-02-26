class GithubHookParser::Person

  def initialize(person)
    @person = person
  end

  def attributes
    {
      username: username,
      email: email,
      name: name,
    }
  end

  def username
    @person.fetch('username')
  end

  def email
    @person.fetch('email')
  end

  def name
    @person.fetch('name')
  end

end

