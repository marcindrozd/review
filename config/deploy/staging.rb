server ENV['STAGING_SERVER'], user: ENV['STAGING_USER'], roles: %w(web app db)

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}"  }
