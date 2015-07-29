require 'rails_helper'

describe Payloads::GithubHooksController do
  let(:zen_msg) { '{"zen": "Always write unit tests."}' }
  let(:payload) { File.read("spec/fixtures/github_hook_commits_payload.json") }

  it "ignores all events other than 'push'" do

    expect(ProjectFromRepositoryParser).not_to receive(:new)
    expect(CommitsFromCommitParsers).not_to receive(:new)

    request.headers['X-GitHub-Event'] = 'ping'
    post :create, zen_msg, format: :json
  end

  it 'renders ok' do
    request.headers['X-GitHub-Event'] = 'push'
    post :create, payload, format: :json
    expect(response.body).to match /ok/
  end
end
