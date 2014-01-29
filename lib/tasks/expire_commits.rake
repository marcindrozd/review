desc 'Reject stale commits states'
task expire_commits: :environment do
  Commit.stale_pending.update_all state: 'rejected'
  Commit.stale_passed.update_all state: 'rejected'
end
