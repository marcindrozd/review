class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :rejected, :pending, :accepted, :total, :grade, :token

  delegate :rejected, to: :stats

  delegate :pending, to: :stats

  delegate :accepted, to: :stats

  delegate :total, to: :stats

  delegate :grade, to: :stats

  private

  def stats
    @project_statistics ||= ProjectStatistics.new(object)
  end

  def token
    object.tokens.first.try(:value)
  end
end
