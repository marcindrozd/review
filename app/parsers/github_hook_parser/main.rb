class GithubHookParser::Main

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def commits
    commit_hashes.map{ |hash| GithubHookParser::Commit.new(hash) }
  end

  def repository
    return unless to_hash.keys.include?('repository')
    GithubHookParser::Repository.new(to_hash.fetch('repository'))
  end

  private

  def commit_hashes
    to_hash.fetch('commits')
  end

  def to_hash
    JSON.parse payload
  end
end
