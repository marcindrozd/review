class CommitsAboutToExpire

  attr_reader :emails_with_commits

  def initialize
    @authors = authors_for_commits_to_expire
    @commits = commits_soon_to_expire
  end

  def commits_for_author(author)
    {
     author.email => commits_soon_to_expire.where(author: author)
    }
  end

  def commits_for_authors
    result = {}
    authors_for_commits_to_expire.each do |author|
      result.merge!(commits_for_author(author))
    end
    return result
  end

  private

  def authors_for_commits_to_expire
    commits_soon_to_expire.map { |p| p.author }.uniq
  end

  def commits_soon_to_expire
    Commit.soon_to_expire
  end
end
