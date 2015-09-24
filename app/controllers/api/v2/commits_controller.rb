class Api::V2::CommitsController < Api::V2::BaseController
  before_filter :ensure_permission, only: :update
  before_action :check_user_roles

  expose(:commit)
  expose(:project) { Project.find_by_name params[:name] }
  expose(:ticket)
  expose(:commits) { find_commits.tagged(params[:tag]) }
  expose(:filtered_commits) { commits.ransack(params[:q]).result }
  expose(:filtered_paginated_commits) { order_commits_if_expires_at_present }
  expose(:updated_tags) { params[:commit][:tag] || [] }

  def index
    respond_with filtered_paginated_commits, meta: { total_pages: commit_pages_count }
  end

  def update
    unless equal_states?
      commit.attempt_transition_to commit_params[:state]
      commit.reviewer_id = commit_params[:reviewer_id]
    end
    if tags_changed?
      commit.tag_list.remove(removed_tags)
    end

    commit.tag_list.add(params[:commit][:tag]) if params[:commit][:tag]
    commit.save
    respond_with commit
    send_state_notification(commit)
  end

  private

  def check_user_roles
    project ||= Project.find(commit.project_id)
    return if current_user.permitted_in_project?(project)
    render json: { message: "You don't have permission to access this resource." }, status: 403
  end

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
    return unless passed?(commit) || rejected?(commit)
    PassRejectNotificationWorker.perform_async(commit.id)
  end
  def passed? commit
    commit.state == "passed"
  end
  def rejected? commit
    commit.state == "rejected"
  end
  def tags_changed?
    !(updated_tags.sort == commit.tag_list.sort)
  end
  def removed_tags
    commit.tag_list - updated_tags
  end
end
