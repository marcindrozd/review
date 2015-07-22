class Api::V2::ProjectsController < Api::V2::BaseController
  expose(:project)
  expose(:projects) { find_projects }
  expose(:paginated_projects) { projects.order(name: :asc).page params[:page] }

  def index
    if params[:name].present?
      project_by_name = Project.find_by_name params[:name]
      respond_with [project_by_name]
    else
      respond_with paginated_projects, meta: { total_pages: project_pages_count }
    end
  end

  def show
    respond_with(project)
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
