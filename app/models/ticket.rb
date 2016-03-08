class Ticket < ActiveRecord::Base
  before_destroy :ensure_project_consistency

  has_many :commits_tickets
  has_many :commits, through: :commits_tickets, dependent: :destroy

  private

  def ensure_project_consistency
    if commits.any? { |c| c.project != commits.first.project }
      fail ActiveRecord::RecordNotDestroyed, 'Ticket has commits from different projects!'
    end
  end
end
