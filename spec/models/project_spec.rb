require 'rails_helper'

describe Project do

  it { should respond_to(:commits) }
  it { should respond_to(:tokens) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:url) }

  describe "with project named something" do

    let!(:project) { described_class.create(name: 'something', url: 'http://test.com') }

    it "doesnt let me create new project with the same name" do
      expect do
        described_class.create(name: project.name)
      end.not_to change{ described_class.all.count }
    end

    it "has uniq token generated" do
      expect(project.tokens.first).not_to be_nil
    end
  end

  describe "project and user roles" do
    let!(:project) { create(:project)  }
    let!(:project_for_contractor) { create(:project, name: "test", url: "http://test.pl") }
    let(:user) { create(:user) }
    let(:contractor) { create(:contractor) }

    context "project has pending commits" do
      let!(:pending_commit) { create(:commit, state: 'pending', project: project) }
      let!(:auto_rejected_commit) { create(:commit, state: 'auto_rejected', project: project) }
      let!(:pending_commit_contractor) do
        create(:commit, state: 'pending', project: project_for_contractor)
      end

      it "returns designated project for the contractor" do
        contractor.add_role :contractor, project_for_contractor
        expect((Project.for_user(contractor)).first.name.to_s).to eq('test')
      end
      it "returns no project for contractor if there is none assigned" do
        contractor.add_role :contractor
        expect(Project.for_user(contractor)).to be_empty
      end
      it "fetches pending commits for projects if role admin" do
        user.add_role :admin
        expect(Project.for_user(user)).not_to be_empty
        expect(Project.for_user(user).count).to eq(2)
      end
      it "fetches pending commits for projects if role developer" do
        user.add_role :developer
        expect(Project.for_user(user)).not_to be_empty
        expect(Project.for_user(user).count).to eq(2)
      end
    end
    context "project has no pending commits" do
      let!(:accepted_commit) { create(:commit, state: 'accepted', project: project) }
      let!(:accepted_commit_contractor) do
        create(:commit, state: 'accepted', project: project_for_contractor)
      end

      it "returns no commits if project present for contractor" do
        contractor.add_role :contractor, project_for_contractor
        expect(Project.for_user(contractor)).to be_empty
      end
      it "dosn't fetch any commits for projects if role admin" do
        user.add_role :admin
        expect(Project.for_user(user)).to be_empty
      end
      it "dosn't fetch any commits for projects if role developer" do
        user.add_role :developer
        expect(Project.for_user(user)).to be_empty
      end
    end
  end
end
