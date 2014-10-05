module Support
  module FakeSlowResponse
    def self.included(base)
      base.before_filter do
        sleep AppConfig.seconds_to_delay_response
      end
    end
  end
end
