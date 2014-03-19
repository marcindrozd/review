require 'spec_helper'

describe Api::V1::ProjectsController do

  let(:project){ Project.create(name: 'something', url: 'http://test.com') }
  let(:token){ project.tokens.first.value }
  describe "when auth fails" do
    before do
      get :index, token: 'wrong_token'
    end

    it { expect(response.status).to eq(401) }
    it { expect(response.body).to include 'not have access' }
  end

  describe "when auth fails" do
    before do
      get :index, token: token
    end

    it { expect(response.status).to eq(200) }
  end

end
