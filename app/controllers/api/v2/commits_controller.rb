class Api::V2::CommitsController < Api::V2::BaseController
  before_filter :ensure_permission, only: :update

  expose(:commit)
  expose(:project) { Project.find_by_name params[:name] }
  expose(:ticket)
  expose(:commits) { find_commits.tagged(params[:tag]) }
  expose(:filtered_commits) { commits.ransack(params[:q]).result }
  expose(:filtered_paginated_commits) { order_commits_if_expires_at_present }

  def index
    respond_with filtered_paginated_commits, meta: { total_pages: commit_pages_count }
  end

  def update
    unless equal_states?
      commit.attempt_transition_to commit_params[:state]
      commit.reviewer_id = commit_params[:reviewer_id]
    end

    commit.tag_list.add(params[:commit][:tag]) if params[:commit][:tag]
    commit.save
    respond_with(commit)
    send_state_notification(commit)
  end

  private

  def equal_states?
    commit.state == commit_params[:state]
  end

  def ensure_permission
    render json: { message: "You are not authorized to do it." }, status: 401 if commit.author == current_user.person
  end

  def commit_params
    params.require(:commit).permit(:state, :reviewer_id)
  end

  def project_name
    params[:name].presence
  end

  def ticket_id
    params[:ticket_id].presence
  end

  def find_commits
    if project_name
      project.commits.order_by_priority
    elsif ticket_id.present?
      ticket.commits
    else
      Commit.all
    end
  end

  def commit_pages_count
    (filtered_commits.count / filtered_paginated_commits.default_per_page.to_f).ceil
  end

  def order_commits_if_expires_at_present
    if params[:q] == "null"
      filtered_commits.order(authored_at: :desc).page params[:page]
    else
      filtered_commits.order(expires_at: :asc).page params[:page]
    end
  end

  def send_state_notification commit
    return unless commit.where.state.in %w(passed rejected)
    PassRejectNotificationWorker.perform_async(commit.id)
  end
end
