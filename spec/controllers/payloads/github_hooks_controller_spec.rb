require 'spec_helper'

describe Payloads::GithubHooksController do

  it "ignores all events other than 'push'" do

    expect(ProjectFromRepositoryParser).not_to receive(:new)
    expect(CommitsFromCommitParsers).not_to receive(:new)

    request.headers['X-GitHub-Event'] = 'ping'
    post :create, { payload: '{"zen":"Always write unit tests."}' }
  end
end
