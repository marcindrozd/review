class GithubHookParser::Main

  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def commits
    commit_hashes.map{ |hash| GithubHookParser::Commit.new(hash) }
  end

  private

  def commit_hashes
    to_hash.fetch('commits')
  end

  def to_hash
    JSON.parse payload
  end
end
