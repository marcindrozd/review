class AboutToExpireNotification < ActionMailer::Base
  include SendGrid
  default from: AppConfig.sendgrid.from_email

  def soon_to_expire_email(email_data)
    sendgrid_disable :ganalytics
    @email = email_data.first
    @commits = email_data.last
    mail(to: @email, subject: 'Some of your commits are about to expire')
  end
end
