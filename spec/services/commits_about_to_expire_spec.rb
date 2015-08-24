require 'rails_helper'

describe CommitsAboutToExpire do
  let!(:expiration_date) { 2.business_hours.from_now }
  let!(:author1){ create(:person, id: 1,  email: 'test@test.com') }
  let!(:author2){ create(:person, id: 2, email: 'test2@test.com') }
  let!(:commit){ create(:commit, author_id: 1, state: 'pending', authored_at: Time.now, expires_at: Time.now) }
  let!(:commit2){ create(:commit, author_id: 2, state: 'pending', authored_at: Time.now, expires_at: Time.now) }

  before do
    commit.update_attributes(expires_at: expiration_date)
    commit2.update_attributes(expires_at: expiration_date)
  end

  it 'returns emails as keys of hash' do
    expect(described_class.new.commits_for_authors.keys).to eq([author1.email, author2.email])
  end
  it 'returns two sets of keys and values' do
    expect(described_class.new.commits_for_authors.count).to eq(2)
  end
end
