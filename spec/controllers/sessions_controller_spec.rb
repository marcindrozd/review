require 'spec_helper'

describe SessionsController do

  describe "when auth fails" do

    it "shows error message we get from callback" do
      message = 'gremlins ate octocats'
      get :failure, message: message
      expect(controller.failure_message).to eq message
    end

    it "shows that the reason is unknown if none given" do
      get :failure
      expect(controller.failure_message).to eq 'unknown'
    end
  end
end
