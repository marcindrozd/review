set :branch, 'master'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}"  }
set :sidekiq_role, :app
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }
set :sidekiq_env, 'staging'
set :pty, false
server ENV['STAGING_SERVER'], user: ENV['STAGING_USER'], roles: %w(web app db)
