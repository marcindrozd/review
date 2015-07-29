require 'rails_helper'

describe GithubHookParser::Repository do

  describe "parsing basic values" do

    let(:repo_parser) { described_class.new url: 'http://example.com/repo_name', name: 'repo_name' }

    it "returns url" do
      expect(repo_parser.url).to eq 'http://example.com/repo_name'
    end

    it "returns name" do
      expect(repo_parser.name).to eq 'repo_name'
    end
  end

end
