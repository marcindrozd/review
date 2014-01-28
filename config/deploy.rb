# -*- encoding : utf-8 -*-

task :production do
  set :stage, 'production'
  set :webserver, "production server name goes here"
end

set :application, "review"

set :rvm_ruby_string, "2.1.0"
set :gateway, "review@s.netguru.co" unless exists?(:gateway)
set :webserver, "s.netguru.co"

set :skip_migrations, true

require 'netguru/capistrano'

after "deploy:update_code", "netguru:precompile"
