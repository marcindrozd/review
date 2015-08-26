desc 'It sends an email notyfing about commits to be expired'
  task commits_about_to_expire_mailer: :environment do
    unless AppConfig.enable_notifications
      emails = CommitsAboutToExpire.new().commits_for_authors
      emails.each_pair do |pair|
        AboutToExpireNotification.soon_to_expire_email(pair).deliver
      end
    end
  end
