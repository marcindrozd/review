require 'rails_helper'

describe Api::V2::CommitsController do
  let(:project) { create(:project, name: 'project1') }
  let(:commit) { create(:commit, author_id: author.id, state: 'pending') }
  let!(:author) { create(:user, email: 'test@test.co') }
  let(:token) { reviewer.tokens.first.value }
  let(:reviewer) { create(:person) }

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
end
