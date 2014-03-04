desc 'This task checks if commit should not be auto rejected.'
task autoreject_commits: :environment do
  Commit.for_state('pending').find_each do |c|
    c.check_outdate
  end
end
