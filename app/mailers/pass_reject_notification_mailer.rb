class PassRejectNotificationMailer < ActionMailer::Base
  include SendGrid
  default from: 'review@app.com'

  def state_notification(commit)
    sendgrid_disable :ganalytics
    @email = commit.author.email
    @url = commit.url
    @state = commit.state
    mail(to: @email, subject: "One of yur commits has been #{@state}")
  end
end
