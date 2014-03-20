class Api::V1::TradeSerializer < ActiveModel::Serializer

  root false

  def attributes
    {
      name: object.name,
      owner: project_owner,
      type: object.trade_details,
      url: review_url,
      expiration_date: object.deadline,
      unreviewed_commits: commits_as_json,
    }
  end

  private

  def project_owner
    object.project_owner.try(:name)
  end

  def review_url
    "http://#{ENV['REVIEW_DOMAIN']}/projects/#{object.id}"
  end

  def commits_as_json
    {
      'by_user'  => commits_by_user,
      'by_state' => commits_by_state,
    }
  end

  def commits_by_state
    {
      "pending"         => object.commits.pending.count,
      "auto_rejected"   => object.commits.auto_rejected.count,
    }
  end

  def commits_by_user
    object.commits.unreviewed.joins(:author).group('people.email').count
  end

end
