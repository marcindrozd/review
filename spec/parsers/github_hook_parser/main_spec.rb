require 'rails_helper'

describe GithubHookParser::Main do

  let(:payload) do
    { commits: [{}, {}] }.to_json
  end

  let(:hook_parser) { described_class.new payload }

  it "returns list of parsed commits" do
    expect(hook_parser.commits.count).to eq 2
  end
end
