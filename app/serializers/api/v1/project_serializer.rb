class Api::V1::ProjectSerializer < ActiveModel::Serializer
  root false

  def attributes
    {
      deadline: deadline,
      commits: commits_as_json,
      project: project_as_json,
      commits_by_state: object.commits.by_state_hash,
    }
  end

  delegate :deadline, to: :object

  def commits
    commits_as_json
  end

  def project
    project_as_json
  end

  private

  def commits_as_json
    {
      'commits_by_user'  => object.commits.by_user_hash,
      'commits_by_state'  => object.commits.by_state_hash,
    }
  end

  def project_as_json
    {
      name: object.name,
      url: object.url,
    }
  end
end
