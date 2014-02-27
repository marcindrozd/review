require 'spec_helper'

describe GithubHookParser::Repository do

  describe "parsing basic values" do

    let(:repo_parser) { described_class.new url: 'http://example.com/repo_name', name: 'repo_name' }

    it "should return url" do
      expect(repo_parser.url).to eq 'http://example.com/repo_name'
    end

    it "should return name" do
      expect(repo_parser.name).to eq 'repo_name'
    end
  end

end
