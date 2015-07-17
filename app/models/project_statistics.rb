class ProjectStatistics
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def rejected
    commits.rejected.count + commits.auto_rejected.count
  end

  def pending
    commits.pending.count
  end

  def accepted
    commits.accepted.count
  end

  def total
    commits.count
  end

  def grade
    return 'bad' if rejected > 0
    'good'
  end

  private

  def commits
    project.commits
  end
end
