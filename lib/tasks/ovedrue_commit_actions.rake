namespace :overdue_commit_actions do

  desc 'It looks for overdue commits and take proper actions'

  task all: :environment do
    auto_reject_overdue_pending_commits
    reject_overdue_passed_commits
  end

  task auto_reject_commits: :environment do
    auto_reject_overdue_pending_commits
  end

  task reject_commits: :environment do
    reject_overdue_passed_commits
  end

  private

  def auto_reject_overdue_pending_commits
    puts "\nlooking for overdue pending commits: "
    Commit.to_auto_reject.find_each do |pending_commit|
      pending_commit.overdue_actions
      print '.'
    end
    puts "\ndone\n"
  end

  def reject_overdue_passed_commits
    puts "\nlooking for overdue passed commits: "
    Commit.to_reject.find_each do |passed_commit|
      passed_commit.overdue_actions
      print '.'
    end
    puts "\ndone\n"
  end
end
