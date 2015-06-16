server ENV['PRODUCTION_SERVER'], user: ENV['PRODUCTION_USER'], roles: %w(web app db)

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}"  }
