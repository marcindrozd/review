desc 'This task checks if commit should not be auto rejected.'
task autoreject_commits: :environment do
  Commit.to_auto_reject.find_each(&:check_outdate)
end
