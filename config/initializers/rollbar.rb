require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = ENV['SECRET_KEY_BASE']

  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  end

end
