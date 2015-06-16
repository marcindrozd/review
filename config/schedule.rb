every 1.day, at: '3:00 am' do
  rake "netguru:backup"
end

every 15.minutes do
  rake "autoreject_commits"
end
