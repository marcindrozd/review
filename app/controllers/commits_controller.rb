class CommitsController < ApplicationController
  include Support::FakeSlowResponse

  before_filter :ensure_permission, only: :update

  expose(:commit)
  expose(:project)
  expose(:ticket)
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

  def ensure_permission
    render json: { message: "You are not authorized to do it." }, status: 401 if commit.author == current_user.person
  end

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
    if project_id.present?
      project.commits
    elsif ticket_id.present?
      ticket.commits
    else
      Commit.all
    end
  end
end
