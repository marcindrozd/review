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

  describe '#session' do
    let(:callback) { post :create, provider: 'twitter' }
    let(:user)     { }

    before(:all) { OmniAuth.config.test_mode = true }

    before do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        uid:      '123456',
        info: {
          nickname:     'johnqpublic',
          name:         'John Q Public',
          email:        'sdfsdf@sdfsdf.de',
          image:        'http://example.com/picture.jpg',
        }
      })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it 'signs up user' do
      expect { callback }.to change { User.count }.by(1)
    end

    it 'signs in user' do
      callback
      expect(controller.current_user).to eq User.last
    end

    it 'redirects to root path' do
      callback
      expect(response).to redirect_to root_path
    end

  end

end
