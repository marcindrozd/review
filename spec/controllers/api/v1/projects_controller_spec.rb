require 'spec_helper'

describe Api::V1::ProjectsController do

  let(:project) { create(:project) }

  describe "when auth fails" do
    before do
      get :show, id: project.id, token: 'wrong_token'
    end

    it { expect(response.status).to eq(401) }
    it { expect(response.body).to include 'not have access' }
  end

  describe "when auth fails" do
    before do
      get :show, id: project.id, token: project.token
    end

    it { expect(response.status).to eq(200) }
  end

end
