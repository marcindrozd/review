class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :rejected, :pending, :accepted, :total, :grade, :token
  has_many :tokens

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

  def token
    tokens.first.try(:value)
  end
end
