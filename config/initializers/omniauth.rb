Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, AppConfig.github.appkey, AppConfig.github.secret
end
