server ENV['PRODUCTION_SERVER'], user: ENV['PRODUCTION_USER'], roles: %w(web app db)
after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application} --set environment=production"
  end
end
