class InvitationMailer < ActionMailer::Base
  default from: 'review@app.com'

  def invitation_email(invitation, auth_url)
    @invitation = invitation
    @auth_url = auth_url + "?invitation_token=#{@invitation.token}"
    mail(to: @invitation.email, subject: 'Invitation to review app')
  end
end
