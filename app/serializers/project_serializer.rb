class ProjectSerializer < ApplicationSerializer
  attributes :id, :name, :rejected, :pending, :accepted, :total, :grade, :token, :url
  delegate :grade, :total, :accepted, :pending, :rejected, to: :stats

  private

  def stats
    @project_statistics ||= ProjectStatistics.new(object)
  end

  def token
    object.tokens.first.try(:value)
  end
end
