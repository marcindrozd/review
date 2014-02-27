require 'spec_helper'

describe Api::V1::ProjectsController do

  let(:project) { create(:project) }

  describe "when auth fails" do
    before do
      get :show, id: project.id, token: 'wrong_token'
    end

    it { response.status.should == 401 }
    it { response.body.should include 'not have access' }
  end

  describe "when auth fails" do
    before do
      get :show, id: project.id, token: project.token
    end

    it { response.status.should == 200 }
  end

end
