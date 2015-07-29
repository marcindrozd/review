require 'rails_helper'

describe Api::V1::TradeController do

  let(:project) { Project.create(name: 'something', url: 'http://test.com') }
  let(:admin) { User.create }
  let(:admin_token) { admin.tokens.first.value }

  before { admin.add_role :admin }

  describe 'get #index' do
    context 'wrong token given' do
      it 'returns 401' do
        get :index, token: 'wrong_token'
        expect(response.status).to eq(401)
      end
    end

    context 'admin token given' do
      it 'returns 200' do
        project.commits.create(message: '[#123]')
        get :index, token: admin_token
        expect(response.status).to eq(200)
      end
    end
  end
end
