require 'rails_helper'

describe CommitFix do
  let(:project) { create :project }
  let(:fixing_commit) { create :commit, :with_project, project: project }
  let(:commit_fix) do
    build :commit_fix, :with_commits, fixing_commit: fixing_commit, fixed_commit: fixed_commit
  end

  context 'fixed commit and fixing commit have different projects' do
    let(:another_project) { create :project }
    let(:fixed_commit) { create :commit, :with_project, project: another_project }

    it 'does not pass validation' do
      expect(commit_fix).to be_invalid
    end
  end

  context 'fixed commit and fixing commit have the same projects' do
    let(:fixed_commit) { create :commit, :with_project, project: project }

    it 'passes validation' do
      expect(commit_fix).to be_valid
    end
  end
end
