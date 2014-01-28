class CommitsController < ApplicationController

  include Support::FakeSlowResponse

  expose(:commit)
  expose(:commits) { find_commits }

  respond_to :json

  def index
    respond_with(commits)
  end

  def update
    commit.attempt_transition_to commit_params[:state]
    commit.save
    respond_with(commit)
  end

  private

  def commit_params
    params.require(:commit).permit(:state)
  end

  def project_id
    params[:project_id].presence
  end

  def ticket_id
    params[:ticket_id].presence
  end

  def find_commits
    commits = Commit.all
    commits = commits.where(project_id: project_id) if project_id.present?
    commits = commits.where(ticket_ids: ticket_id) if ticket_id.present?
    commits
  end
end
