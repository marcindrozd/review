class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :rejected, :pending, :accepted, :total, :grade

  def rejected
    stats.rejected
  end

  def pending
    stats.pending
  end

  def accepted
    stats.accepted
  end

  def total
    stats.total
  end

  def grade
    stats.grade
  end

  private

  def stats
    ProjectStatistics.new(object)
  end
end
