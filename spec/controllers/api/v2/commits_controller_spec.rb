require 'rails_helper'

describe Api::V2::CommitsController do
  let!(:project) { create(:project, name: 'project1') }
  let!(:commit) do
    create(:commit,
           project_id: project.id,
           author_id: author.id,
           authored_at: Date.parse,
           expires_at: Date.tomorrow,
           state: 'pending')
  end
  let!(:author) { create(:person, email: 'test@test.co') }
  let(:token) { reviewer.tokens.first.value }
  let(:reviewer) { create(:user, email: 'test2@test.co', person_id: reviewer_person.id) }
  let(:reviewer_person) { create(:person, email: 'test2@test.co') }
  let!(:add_role) do
    reviewer.add_role(:contractor, project)
  end

  describe '#update' do
    let(:valid_params) { {state: 'rejected', tag: ['test_tag']}  }

    context 'there is a valid user' do

      before do
        session[:user_id] = reviewer.id
        put :update, id: commit.id, commit: valid_params, format:  :json
      end

      it 'checks the response status' do
        expect(response.status).to eq(204)
      end
      it 'checks if the status has changed' do
        expect(commit.reload.state).to eq('rejected')
      end
      it 'adds a tag to a given commit' do
        expect(commit.tag_list).to eq(['test_tag'])
      end
      it 'reomves a tag' do
        put :update, id: commit.id, commit: { tag: ['test_tag']} , format:  :json
        expect(commit.tag_list).to eq(['test_tag'])
      end
    end
    context 'removes tags with valid user' do
      before do
        session[:user_id] = reviewer.id
        commit.tag_list = ['test_tag']
        put :update, id: commit.id,  commit: {tag: [], state: 'pending'}, format:  :json
      end
      it 'returns status 204' do
        expect(response.status).to eq(204)
      end
      it 'reomves a tag' do
        expect(commit.reload.tag_list).to eq([])
      end
    end
    context 'there is no valid user' do
      before do
        put :update, id: commit.id, commit: valid_params, format:  :json
      end
      it 'checks the response status' do
        put :update, id: commit.id, commit: valid_params, format: :json
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#index' do
    context 'with valid user returns all commits' do
      let(:params) { {q: 'null', name: project.name} }
      let!(:pending_commit_expiring_tomorrow) { commit }
      let!(:pending_commit_expiring_today) do
        create(:commit,
               project_id: project.id,
               author_id: author.id,
               expires_at: Date.today,
               state: 'pending')
      end
      %w(rejected auto_rejected passed fixed accepted).each do |state|
        let!("new_#{state}_commit") do
          create(:commit,
                 project_id: project.id,
                 author_id: author.id,
                 created_at: Date.today,
                 state: state)
        end
        let!("old_#{state}_commit") do
          create(:commit,
                 project_id: project.id,
                 author_id: author.id,
                 created_at: Date.yesterday,
                 state: state)
        end
      end

      before :each do
        session[:user_id] = reviewer.id
        get :index, q: 'null', name: project.name, format: :json
      end

      it 'responsd with 200 status' do
        expect(response.status).to eq(200)
      end

      it 'returns twelve commits' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(12)
      end

      it 'returns properly ordered commits' do
        commits = JSON.parse(response.body).fetch('commits')
        expect(commits.map { |c| c['id'] }).to eq [
                                                    old_rejected_commit.id,
                                                    new_rejected_commit.id,
                                                    old_auto_rejected_commit.id,
                                                    new_auto_rejected_commit.id,
                                                    old_passed_commit.id,
                                                    new_passed_commit.id,
                                                    pending_commit_expiring_today.id,
                                                    pending_commit_expiring_tomorrow.id,
                                                    new_fixed_commit.id,
                                                    old_fixed_commit.id,
                                                    new_accepted_commit.id,
                                                    old_accepted_commit.id
                                                  ]
      end
    end

    context 'with valid user returns all but accepted and fixed' do
      let!(:commit_accepted) do
        create(:commit,
               project_id: project.id,
               author_id: author.id,
               authored_at: Date.parse - 2.days,
               state: 'accepted')
      end
      let!(:commit_fixed) do
        create(:commit,
               project_id: project.id,
               author_id: author.id,
               state: 'fixed')
      end
      let!(:commit_pending) do
        create(:commit,
               project_id: project.id,
               author_id: author.id,
               expires_at: Date.parse - 1.day,
               state: 'pending')
      end

      before :each do
        session[:user_id] = reviewer.id
        get :index, q: {state_not_in: ['accepted', 'fixed']}, name: project.name, format:  :json
      end

      it 'responds with 200 status' do
        expect(response.status).to eq(200)
      end
      it 'returns two commits' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(2)
      end
      it 'returns only the pending commit' do
        expect(JSON.parse(response.body).fetch('commits').first['state']).to eq('pending')
      end
      it 'returns commits in order expires_at asc' do
        commits = JSON.parse(response.body).fetch('commits')
        expect(commits.first.fetch('expires_at') < commits.last.fetch('expires_at'))
      end
    end
    context 'with valid user and tags' do
      let(:commit_tag1) { create(:commit, project_id: project.id) }
      let(:commit_tag2) { create(:commit, project_id: project.id) }
      let(:commit_tag3) { create(:commit, project_id: project.id) }

      before do
        commit_tag1.tag_list.add('test_tag')
        commit_tag1.save
        commit_tag2.tag_list.add('test_tag')
        commit_tag2.save
        commit_tag3.tag_list.add('test_tag2')
        commit_tag3.save
      end

      before :each do
        session[:user_id] = reviewer.id
        get :index, tag: 'test_tag', name: project.name, format:  :json
      end

      it 'returns 200 status' do
        expect(response.status).to eq(200)
      end
      it 'returns two commits that match the params' do
        expect(JSON.parse(response.body).fetch('commits').count).to eq(2)
      end
      it 'checks if the commits have the requested tags' do
        commits = JSON.parse(response.body).fetch('commits')
        expect(commits.map { |c| c.fetch('tag') }).to eq([['test_tag'], ['test_tag']])
      end
    end
  end
end
