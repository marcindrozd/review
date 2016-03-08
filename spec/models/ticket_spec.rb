require 'rails_helper'

describe Ticket do
  let(:project) { create :project }
  let(:commit1) { create :commit, :with_project, project: project }
  let(:ticket) { build :ticket, :with_commits, commits: [commit1, commit2] }

  context 'commits have different projects' do
    let(:another_project) { create :project }
    let(:commit2) { create :commit, :with_project, project: another_project }

    it 'does not pass validation' do
      expect(ticket).to be_invalid
    end
  end

  context 'commits have the same projects' do
    let(:commit2) { create :commit, :with_project, project: project }

    it 'passes validation' do
      expect(ticket).to be_valid
    end
  end
end
