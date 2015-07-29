require 'rails_helper'

describe GithubHookParser::Commit do

  describe "parsing basic values" do

    let(:commit_parser) { described_class.new id: 'deadbeef', url: 'http://example.com/commit', message: 'fixed a bug' }

    it "returns remote_id" do
      expect(commit_parser.remote_id).to eq 'deadbeef'
    end

    it "returns url" do
      expect(commit_parser.url).to eq 'http://example.com/commit'
    end

    it "returns commit message" do
      expect(commit_parser.message).to eq 'fixed a bug'
    end
  end

  describe "parsing referenced commits from message" do

    let(:commit_parser) { described_class.new message: 'fixes 55e5a7b12d413ea605dda91b5911d5a27cafdfd6' }

    it "returns a list of remote ids" do
      expect(commit_parser.referenced_commits).to eq ['55e5a7b12d413ea605dda91b5911d5a27cafdfd6']
    end
  end

  describe "parsing ticket ids from message" do

    let(:commit_parser) { described_class.new(message: '#1234 #56789') }

    it "returns a list of ticket parsers" do
      expect(commit_parser.tickets.count).to eq 2
    end
  end
end
