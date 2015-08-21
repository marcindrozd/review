class CommitsFromCommitParsers
  attr_reader :commit_parsers

  def initialize(commit_parsers)
    @commit_parsers = commit_parsers
  end

  def create
    add_batch_remote
  end

  def add_batch_remote
    commit_parsers.map{ |commit_parser| add_remote commit_parser }.compact
  end

  def add_remote(commit_parser)
    unless Commit.where(remote_id: commit_parser.remote_id).exists?
      Commit.create(commit_parser.attributes) do |commit|
        commit.add_remote_tickets commit_parser.tickets
        commit.set_commit_author commit_parser.author
        commit.tag_list.add(commit_parser.file_extenssions)
      end
    end
  end
end
