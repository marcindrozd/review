require 'rails_helper'

describe Api::V2::CommitsController do
  let(:project) { create(:project, name: 'project1') }
  let!(:commit) { create(:commit, project_id: project.id, author_id: author.id, state: 'pending') }
  let!(:author) { create(:person, email: 'test@test.co') }
  let(:token) { reviewer.tokens.first.value }
  let(:reviewer) { create(:user, email: 'test2@test.co', person_id: reviewer_person.id) }
  let(:reviewer_person) { create(:person, email: 'test2@test.co') }
  let!(:add_role) do
    reviewer.add_role(:contractor, project)
  end

  describe '#update' do
    let(:valid_params) { { state: 'rejected', project_id: project.id }  }

    context 'with a valid user' do
      before do
        session[:user_id] = reviewer.id
        put :update, id: commit.id, commit: valid_params, format: :json
      end

      it 'checks the response status' do
        expect(response.status).to eq(204)
      end

      it 'checks if the status has changed' do
        expect(commit.reload.state).to eq('rejected')
      end
    end

    context 'with invalid user' do
      it 'checks the response status' do
        put :update, id: commit.id, commit: valid_params, format: :json
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#index' do
    let!(:commit_accepted) do
      create(:commit, project_id: project.id, author_id: author.id, state: 'accepted')
    end

    context 'with valid user returns all commits' do
      before :each do
        session[:user_id] = reviewer.id
        get :index, q: 'null', name: project.name, format: :json
      end

      it 'responsd with 200 status' do
        expect(response.status).to eq(200)
      end

      it 'returns two commits' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(2)
      end
    end

    context 'with valid user returns all but accepted and fixed' do
      let!(:commit_accepted) { create(:commit, project_id: project.id, author_id: author.id, state: 'fixed') }

      before :each do
        session[:user_id] = reviewer.id
        get :index, q: { state_not_in: ['accepted', 'fixed'] }, name: project.name, :format => :json
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
end
