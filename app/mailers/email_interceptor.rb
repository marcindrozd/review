class EmailInterceptor
  def self.delivering_email(message)
    message.to = AppConfig.email_for_interceptor
  end
end
