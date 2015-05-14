lock '3.2.1'

set :application, "review"
set :repo_url,  "git@github.com:netguru/review.git"
set :deploy_to, ENV['DEPLOY_PATH']

set :linked_files, %w(config/database.yml config/sec_config.yml)

# Make sure that folders listed here are present in /app/shared, copy them if not
set :linked_dirs, %w(log tmp vendor/bundle public/uploads)
