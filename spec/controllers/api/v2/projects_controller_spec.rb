require 'rails_helper'

describe Api::V2::ProjectsController do
  let!(:project) { create(:project, name: 'test_project') }
  let!(:project2) { create(:project, name: 'test_project2', url: 'test.project.com') }
  let(:user) { create(:user) }

  describe "#index" do
    context 'user has role devloper' do
      let!(:add_role) do
        user.add_role :developer
      end

      before :each do
        session[:user_id] = user.id
        get :index, format: :json
      end

      it 'returns 200 response code' do
        expect(response.status).to be(200)
      end
      it 'responds with a list with two projects' do
        expect(JSON.parse(response.body).fetch('projects').count).to eq(2)
      end
    end
    context 'user has role admin' do
      let!(:add_role) do
        user.add_role :developer
      end

      before :each do
        session[:user_id] = user.id
        get :index, format: :json
      end

      it 'returns 200 status code' do
        expect(response.status).to be(200)
      end
      it 'responds with a list of two projects' do
        expect(JSON.parse(response.body).fetch('projects').count).to eq(2)
      end
      it 'the projects are ordered name asc' do
        projects = JSON.parse(response.body).fetch('projects')
        expect(projects.first.fetch('name') < projects.last.fetch('name'))
      end
    end
    context 'user has role contractor with project' do
      let!(:add_role) do
        user.add_role(:contractor, project)
      end

      before :each do
        session[:user_id] = user.id
        get :index, format: :json
      end

      it 'returns 200 code' do
        expect(response.status).to be(200)
      end
      it 'responds with a list of two projects' do
        expect(JSON.parse(response.body).fetch('projects').count).to eq(1)
      end
    end
    context 'user has role developer and uses query by name' do
      let!(:add_role) do
        user.add_role :developer
      end

      before :each do
        session[:user_id] = user.id
        get :index, name: project.name, format: :json
      end
      it 'returns 200 status code' do
        expect(response.status).to be(200)
      end
      it 'responds with a list two projects' do
        expect(JSON.parse(response.body).fetch('projects').count).to eq(1)
      end
      it 'returns the correct project' do
        expect(JSON.parse(response.body).fetch('projects').first.fetch('name')).to eq(project.name)
      end
    end
    context 'there is a user but project of that name is not there' do
      let!(:add_role) do
        user.add_role :developer
      end

      before :each do
        session[:user_id] = user.id
        get :index, name: 'fake_project_name', format: :json
      end
      it 'responds with 404 status code' do
        expect(response.status).to be(404)
      end
    end
  end
  describe '#show' do
    context 'user has role developer and project exists' do
      let!(:add_role) do
          user.add_role :developer
        end
        before :each do
          session[:user_id] = user.id
          get :show, name: project.name, format: :json
        end

        it 'returns status 200 code' do
          expect(response.status).to eq(200)
        end
        it 'returns the correct project' do
          parsed_project = JSON.parse(response.body).fetch('projects').first
          expect(parsed_project.fetch('name')).to eq(project.name)
        end
    end
    context 'user has role contractor' do
      let!(:add_role) do
          user.add_role :contractor, project
        end
        before :each do
          session[:user_id] = user.id
          get :show, name: project.name, format: :json
        end

        it 'returns status 200' do
          expect(response.status).to eq(200)
        end
        it 'returns the correct project' do
          parsed_project = JSON.parse(response.body).fetch('projects').first
          expect(parsed_project.fetch('name')).to eq(project.name)
        end
    end
    context 'contractor dose not have access to project' do
      let!(:add_role) do
        user.add_role(:contractor, project2)
      end
      before :each do
        session[:user_id] = user.id
        get :show, name: project.name, format: :json
      end

      it 'returns status 403' do
        expect(response.status).to eq(403)
      end
    end
  end
end
