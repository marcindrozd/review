class Api::V2::TicketsController < Api::V2::BaseController
  expose(:invitations)
  expose(:paginated_invitations) { invitations.order(created_at: :desc).page params[:page] }

  def index
    respond_with paginated_invitations), meta: { total_pages: invitation_pages_count }
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :role, :project_ids)
  end

  def invitation_pages_count
    (invitations.count / paginated_invitations.default_per_page.to_f).ceil
  end
end
