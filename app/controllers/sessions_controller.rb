class SessionsController < ApplicationController
  skip_before_filter :authentication_check

  layout 'static'

  respond_to :json, only: [:destroy]

  expose(:failure_message) { params[:message].presence || 'unknown' }
  expose(:github_auth_path) { '/auth/github' }

  def index
    check_invitation_token
  end

  def create
    user = UserFromAuth.new(auth_hash).find_or_build
    if user.persisted? || user.save
      invitation_roles(user)
      sign_in user
      redirect_to root_path
    else
      render text: "Couldn't log you in!"
    end
  end

  def destroy
    sign_out
    respond_with nil, location: auth_url
  end

  def failure
  end

  private

  def check_invitation_token
    return unless params[:invitation_token]
    session[:invitation_token] = params[:invitation_token]
  end

  def invitation_roles(user)
    return unless session[:invitation_token]
    invitation = Invitation.find_by(token: session[:invitation_token])
    add_invitation_roles(invitation, user)
    session.delete(:invitation_token)
  end

  def add_invitation_roles(invitation, user)
    projects = invitation.project_ids
    role = invitation.role
    projects ? projects.each { |id| user.add_role role, Project.find(id) } : user.add_role(role)
    invitation.update_attributes(accepted: true)
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
