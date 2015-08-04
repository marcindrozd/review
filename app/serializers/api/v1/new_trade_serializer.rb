class Api::V1::NewTradeSerializer < ActiveModel::Serializer
  attributes :project, :commits, :deadline

  private

  def commits_to_review
    object.commits.unreviewed
  end

  def url
    "#{AppConfig.app_host}/projects/#{object.name}/commits"
  end

  def commits
    {
      pending: object.commits.pending.count,
      rejected: object.commits.rejected.count,
    }
  end

  def project
    return {name: object.name, url: url, commits_to_review: object.commits.unreviewed }
  end

  def deadline
    last_commit = object.commits.last
    if last_commit.present?
      last_commit.created_at
    else
      DateTime.current
    end
  end
end
