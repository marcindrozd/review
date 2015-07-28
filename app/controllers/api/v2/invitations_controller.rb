class Api::V2::InvitationsController < Api::V2::BaseController
  before_action :check_permission
  expose(:invitations)
  expose(:invitation, attributes: :invitation_params)
  expose(:paginated_invitations) { invitations.order(created_at: :desc).page params[:page] }

  def index
    respond_with paginated_invitations, meta: { total_pages: invitation_pages_count }
  end

  def create
    if invitation.save
      InvitationMailer.invitation_email(invitation, auth_url).deliver
    end
    respond_with invitation, location: false
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :role, project_ids: [])
      .merge(sender_id: current_user.id)
  end

  def invitation_pages_count
    (invitations.count / paginated_invitations.default_per_page.to_f).ceil
  end
end
