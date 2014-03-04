require 'spec_helper'

describe Commit do

  it { should respond_to(:project) }
  it { should respond_to(:project_id) }

  let(:remote_id) { 'asdf' }
  let(:commit_author) { GithubHookParser::Person.new('name'=> 'levis', 'email'=> 'john@levis.com', 'username'=> 'john levis') }

  let(:commit_attributes) do
    {
      'url' => 'http://test.host/netguru/review/commit/123123',
      'message' => 'cool commit message',
      'remote_id' => remote_id,
    }
  end

  let(:remote_commit) do
    double('RemoteCommit', remote_id: remote_id, attributes: commit_attributes, tickets: [], author: commit_author)
  end

  describe "#get_associated_project" do

    let(:commit_creation){ -> { Commit.create(commit_attributes) } }

    it "should create new project for new commit" do
      expect(commit_creation).to change{ Project.count }
    end

    it "should not create project duplicates" do
      commit_creation.call
      expect(commit_creation).not_to change{ Project.count }
    end
  end

  describe 'commit creation' do
    it "should add new commit" do
      expect do
        described_class.add_remote(remote_commit)
      end.to change{ described_class.count }.by(1)
    end

    it "should not create new commit twice" do
      expect do
        2.times { described_class.add_remote(remote_commit) }
      end.to change{ described_class.count }.by(1)
    end
  end

  describe 'state machine' do
    let(:commit){ Commit.create(commit_attributes) }

    it 'ensures initial state is `pending`' do
      expect(commit).to be_pending
    end

    [:reject, :pass, :accept].permutation(2).to_a.each do |from, to|
      it "allows to change states between #{from} and #{to}" do
        expect do
          commit.public_send(from)
          commit.public_send(to)
        end.to be_true
      end
    end

    it 'disallows to change state to the same we are in' do
      [:reject, :pass, :accept].each do |action|
        expect(commit.public_send(action)).to be_true
        expect(commit.public_send(action)).to be_false
      end
    end
  end
end
