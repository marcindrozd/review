require 'rails_helper'

shared_examples 'destroys projects with given name and all associations' do
  it 'destroys projects with given name' do
    expect{ subject.invoke(project.name) }
      .to change{ Project.count }.from(project_number[:before]).to(project_number[:after])
  end

  it 'destroys project commits' do
    expect{ subject.invoke(project.name) }
      .to change{ Commit.count }.from(4 * project_number[:before]).to(4 * project_number[:after])
  end

  it 'destroys project commits fixes' do
    expect{ subject.invoke(project.name) }
      .to change{ CommitFix.count }.from(project_number[:before]).to(project_number[:after])
  end

  it 'destroys project tickets' do
    expect{ subject.invoke(project.name) }
      .to change{ Ticket.count }.from(project_number[:before]).to(project_number[:after])
  end

  it 'destroys all relevant records from commits_tickets table' do
    expect{ subject.invoke(project.name) }
      .to change{ CommitsTicket.count }.from(2 * project_number[:before]).to(2 * project_number[:after])
  end

  it 'destroys all project relate roles' do
    expect{ subject.invoke(project.name) }
      .to change{ Role.count }.from(project_number[:before]).to(project_number[:after])
  end

  it 'destroys all relevant records from users_roles table' do
    expect{ subject.invoke(project.name) }
      .to change{ UsersRole.count }.from(project_number[:before]).to(project_number[:after])
  end

  it 'destroys project tokens' do
    expect{ subject.invoke(project.name) }
      .to change{ Token.where(tokenable_type: 'Project').count }
      .from(project_number[:before]).to(project_number[:after])
  end

  it 'does not destroy any users' do
    expect{ subject.invoke(project.name) }.not_to change{ User.count }
  end
end

describe 'remove_project' do
  let!(:project) { create :project_with_all_associations }
  let!(:project_to_remain) { create :project_with_all_associations }
  let(:subject) { Rake::Task['remove_project'] }

  before(:all) { Review::Application.load_tasks }

  before { subject.reenable }

  context 'when project owner has other projects' do
    let(:project_number) { { before: 3, after: 2 } }

    before { create :project_with_all_associations, project_owner: project.project_owner }

    it 'does not destroy project owner' do
      expect{ subject.invoke(project.name) }.not_to change{ ProjectOwner.count }
    end

    include_examples 'destroys projects with given name and all associations'
  end

  context 'when project owner does not have other projects' do
    let(:project_number) { { before: 2, after: 1 } }

    it 'destroys project owner' do
      expect{ subject.invoke(project.name) }
        .to change{ ProjectOwner.count }.from(project_number[:before]).to(project_number[:after])
    end

    include_examples 'destroys projects with given name and all associations'
  end

  context 'when some commit fixes commit from another project' do
    let(:project_number) { { before: 3, after: 3 } }
    let(:another_project) { create :project, :with_project_owner, :with_role, :with_ticket }
    let(:commit_fix) { create :commit_fix, :with_commits, project: another_project }

    before { commit_fix.fixed_commit.update_attribute :project, project }

    it 'raises exception and does not remove any projects' do
      expect(Project.count).to eq project_number[:before]
      expect{ subject.invoke(another_project.name) }
        .to raise_error(ActiveRecord::RecordNotDestroyed)
      expect(Project.count).to eq project_number[:after]
    end
  end

  context 'when there are two projects with the same name' do
    let(:project_number) { { before: 3, after: 1 } }
    let(:another_project) { create :project_with_all_associations }

    before { another_project.update_attribute :name, project.name }

    include_examples 'destroys projects with given name and all associations'
  end

  context 'when commits in ticket have different projects' do
    let(:project_number) { { before: 3, after: 3 } }
    let(:another_project) { create :project, :with_project_owner, :with_role, :with_commit_fix }
    let(:ticket) { create :ticket, :with_commits, project: another_project }

    before { ticket.commits.first.update_attribute :project, project }

    it 'raises exception and does not remove any projects' do
      expect(Project.count).to eq project_number[:before]
      expect{ subject.invoke(another_project.name) }
        .to raise_error(ActiveRecord::RecordNotDestroyed)
      expect(Project.count).to eq project_number[:after]
    end
  end

  context 'when all commit fixes and tickets have consistent projects' do
    let(:project_number) { { before: 2, after: 1 } }

    include_examples 'destroys projects with given name and all associations'
  end
end
