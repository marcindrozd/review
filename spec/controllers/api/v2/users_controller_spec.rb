require 'rails_helper'

describe Api::V2::UsersController do
  describe '#index' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    before do
      session[:user_id] = user1.id
    end
    before :each do
      get :index, format: :json
    end

    it 'returns status code 200' do
     expect(response.status).to be(200)
    end
    it 'returns a list of users' do
     expect(JSON.parse(response.body).fetch('users').count).to be(2)
    end
  end
  describe "#show" do
    let!(:user) { create(:user) }
    before do
      session[:user_id] = user.id
    end
    before :each do
      get :show, id: user.id, format: :json
    end

    it 'returns status code200' do
      expect(response.status).to be(200)
    end
    it 'returns a the correct user' do
      expect(JSON.parse(response.body).fetch('user').first.last).to eq(user.id)
    end
  end
  describe "#update" do
    context 'user is admin' do
      let(:user) {create(:user, name: 'John')}
      before do
        user.add_role :admin
        session[:user_id] = user.id
      end
      before :each do
        get :update, id: user.id, user: {name: 'Jane'}, format: :json
      end

      it 'returns response status 200' do
        expect(response.status).to eq(200)
      end
      it 'changes user name' do
        user.reload
        expect(user.name).to eq('Jane')
      end
    end
    context 'user not admin' do
      let(:user) {create(:user, name: 'John')}
      before do
        user.add_role :developer
        session[:user_id] = user.id
      end
      before :each do
        get :update, id: user.id, user: {name: 'Jane'}, format: :json
      end
      it 'expect response code 401' do
        expect(response.status).to be(401)
      end
      it 'name dose not change' do
        user.reload
        expect(user.name).to eq('John')
      end
    end
  end
end
