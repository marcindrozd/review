class Api::V2::ProjectsController < Api::V2::BaseController
  expose(:project_by_name) { Project.where(name: params[:name]) }
  expose(:projects) { find_projects.fuzzy(params[:query]) }
  expose(:paginated_projects) do
    projects.order(name: :asc).page params[:page]
  end

  def index
    if project_by_name.empty? && params[:name]
      respond_with "{'error': 'not_found'}", status: 404
    elsif project_by_name.present?
      respond_with project_by_name
    else
      respond_with paginated_projects, meta: { total_pages: project_pages_count }
    end
  end

  def show
    return unless params[:name]
      if admin_or_developer?
        respond_with project_by_name
      elsif contractor?(project_by_name.first)
        respond_with project_by_name
      else
        respond_with 'forbidden', status: 403, format: :json
      end
  end


  private

  def find_projects
    if admin_or_developer?
      Project.all
    else
      Project.user_resources(current_user)
    end
  end
  def project_pages_count
    (projects.count / paginated_projects.default_per_page.to_f).ceil
  end
  def admin_or_developer?
    current_user.has_role?(:admin) || current_user.has_role?(:developer)
  end
  def contractor?(project)
    current_user.has_role? :contractor, project
  end
end
