class Api::V2::ProjectsController < Api::V2::BaseController
  expose(:project)
  expose(:projects) { find_projects }

  def index
    renspond_with(projects)
  end

  def show
    renspond_with(project)
  end

  private

  def find_projects
    if current_user.admin?
      Project.all
    else
      Project.joins(:permissions).where(permissions: { user_id: current_user.id, allowed: true })
    end
  end
end
