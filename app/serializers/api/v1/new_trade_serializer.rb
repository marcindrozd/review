class Api::V1::NewTradeSerializer < ActiveModel::Serializer
  attributes :project, :commits, :deadline

  private

  def commits_to_review
    object.commits.unreviewed
  end

  def url
    "#{ENV['REVIEW_DOMAIN']}/projects/#{object.name}"
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
    object.commits.last.created_at
  end
end
