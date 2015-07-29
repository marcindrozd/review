require 'rails_helper'

describe GithubHookParser::PivotalTicket do
  let(:pivotal_ticket) { described_class.new('12345') }
  let(:message) { "this is a test commit [#54321]" }

  it 'creates a ticket' do
    expect(pivotal_ticket.url).to eq("https://www.pivotaltracker.com/story/show/12345")
  end

  it 'extracts ticket id from message' do
    expect(described_class.from_message(message).first.ticket_id).to eq("54321")
  end

  it 'returns ticket type' do
    expect(pivotal_ticket.ticket_type).to eq('pivotal')
  end
end
