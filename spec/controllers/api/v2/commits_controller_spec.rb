require 'rails_helper'

describe Api::V2::CommitsController do
  let(:project) { create(:project, name: 'project1') }
  let!(:commit) { create(:commit, project_id: project.id, author_id: author.id, state: 'pending') }
  let!(:author) { create(:user, email: 'test@test.co') }
  let(:token) { reviewer.tokens.first.value }
  let(:reviewer) { create(:person, email: 'test2@test.co') }

  describe '#update' do
    let(:valid_params) { {state: 'rejected'}  }

    context 'there is a valid user' do
      before do
        session[:user_id] = reviewer.id
        put :update, id: commit.id, commit: valid_params, :format => :json
      end

      it 'checks the response status' do
        expect(response.status).to eq(204)
      end

      it 'checks if the status has changed' do
        expect(commit.reload.state).to eq('rejected')
      end
    end
    context 'there is no valid user' do
      before do
        put :update, id: commit.id, commit: valid_params, :format => :json
      end

      it 'checks the response status' do
        expect(response.status).to eq(302)
      end
    end
  end
  describe '#index' do
    let!(:commit_accepted) { create(:commit, project_id: project.id, author_id: author.id, state: 'accepted') }

    context 'with valid user returns all commits' do
      let(:params) { { q: 'null', name: project.name} }

      before :each do
        session[:user_id] = reviewer.id
        get :index, params: params, :format => :json
      end
      it 'responsd with 200 status' do
        expect(response.status).to eq(200)
      end
      it 'returns two commits' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(2)
      end
    end
    context 'with valid user teruns all but accepted and fixed' do
      let!(:commit_accepted) { create(:commit, project_id: project.id, author_id: author.id, state: 'fixed') }

      before :each do
        session[:user_id] = reviewer.id
        get :index, q: {state_not_in: ['accepted', 'fixed']}, :format => :json
      end

      it 'responsd with 200 status' do
        expect(response.status).to eq(200)
      end
      it 'returns one commit' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(1)
      end
      it 'returns only the pending commit' do
        expect(JSON.parse(response.body).fetch('commits').first['state']).to eq('pending')
      end
    end
end
