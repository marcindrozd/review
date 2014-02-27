class Api::V1::ProjectSerializer < ActiveModel::Serializer

  root false

  def attributes
    {
      deadline: deadline,
      commits: commits_as_json,
      project: project_as_json,
    }
  end

  def deadline
    # TODO
  end

  def commits
    commits_as_json
  end

  def project
    project_as_json
  end

  private

  def commits_as_json
    {
      'by_user' => object.commits.joins(:author).group("people.name").count,
      'by_state' => object.commits.group("state").count
    }
  end

  def project_as_json
    object.attributes.slice('name', 'url')
  end
end
