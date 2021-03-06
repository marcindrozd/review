class Api::V2::CommitsController < Api::V2::BaseController
  before_filter :ensure_permission, only: :update
  before_action :check_user_roles

  expose(:commit)
  expose(:project) { Project.find_by_name params[:name] }
  expose(:ticket)
  expose(:commits) { find_commits.tagged(params[:tag]) }
  expose(:filtered_commits) { commits.ransack(params[:q]).result }
  expose(:filtered_paginated_commits) { sort_commits_by_priority_then_date }
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
      commit.tag_list = updated_tags
    end
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
      project.commits
    elsif ticket_id.present?
      ticket.commits
    else
      Commit.all
    end
  end

  def commit_pages_count
    (filtered_commits.count / filtered_paginated_commits.default_per_page.to_f).ceil
  end

  def sort_commits_by_priority_then_date
    sorted_commits = filtered_commits.sort do |x, y|
      if x.priority != y.priority
        x.priority <=> y.priority
      else
        compare_same_priority_commits(x, y)
      end
    end
    Kaminari.paginate_array(sorted_commits).page params[:page]
  end

  def compare_same_priority_commits(x, y)
    case x.state.to_sym
    when :accepted, :fixed
      y.created_at <=> x.created_at
    when :pending
      x.expires_at <=> y.expires_at
    else
      x.created_at <=> y.created_at
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
    !(commit.tags.sort == updated_tags.sort)
  end
end
