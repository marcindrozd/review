class InvitationMailer < ActionMailer::Base
  include SendGrid
  default from: AppConfig.sendgrid.from_email

  def invitation_email(invitation, auth_url)
    sendgrid_disable :ganalytics
    @invitation = invitation
    @auth_url = auth_url + "?invitation_token=#{@invitation.token}"
    # mail(to: @invitation.email, subject: 'Invitation to review app')
  end
end
