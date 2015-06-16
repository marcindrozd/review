server ENV['STAGING_SERVER'], user: ENV['STAGING_USER'], roles: %w(web app db)

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application} --set environment=staging"
  end
end
