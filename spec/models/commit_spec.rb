require 'spec_helper'

describe Commit do

  it { should respond_to(:project) }
  it { should respond_to(:project_id) }

  let(:remote_id) { 'asdf' }

  let(:commit_attributes) do
    {
      'url' => 'http://test.host/netguru/review/commit/123123',
      'message' => 'cool commit message',
      'remote_id' => remote_id,
    }
  end

  let(:remote_commit) do
    double('RemoteCommit', remote_id: remote_id, attributes: commit_attributes, tickets: [])
  end

  describe "#get_associated_project" do

    let(:commit_creation){ -> { Commit.create(commit_attributes) } }

    it "should create new project for new commit" do
      commit_creation.should change{ Project.count }
    end

    it "should not create project duplicates" do
      commit_creation.call
      commit_creation.should_not change{ Project.count }
    end
  end

  it "should add new commit" do
    -> do
      described_class.add_remote(remote_commit)
    end.should change{ described_class.count }.by(1)
  end

  it "should not create new commit twice" do
    described_class.add_remote(remote_commit)
    -> do
      described_class.add_remote(remote_commit)
    end.should change{ described_class.count }.by(0)
  end

  describe 'state machine' do
    let(:commit){ Commit.create(commit_attributes) }

    it 'ensures initial state is `pending`' do
      commit.pending?.should be_true
    end

    [:reject, :pass, :accept].permutation(2).to_a.each do |from, to|
      it "allows to change states between #{from} and #{to}" do
        commit.public_send(from).should be_true
        commit.public_send(to).should be_true
      end
    end

    it 'disallows to change state to the same we are in' do
      [:reject, :pass, :accept].each do |action|
        commit.public_send(action).should be_true
        commit.public_send(action).should be_false
      end
    end
  end
end
