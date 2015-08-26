class PassRejectNotificationWorker
  include Sidekiq::Worker

  def perform(commit_id)
    commit = Commit.find_by(id: commit_id)
    PassRejectNotificationMailer.state_notification(commit).deliver
  end
end
