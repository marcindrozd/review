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
    respond_with project_by_name
  end

  private

  def find_projects
    if current_user.has_role?(:admin) || current_user.has_role?(:developer)
      Project.all
    else
      Project.user_resources(current_user)
    end
  end

  def project_pages_count
    (projects.count / paginated_projects.default_per_page.to_f).ceil
  end
end
