require 'rails_helper'

describe CommitsAboutToExpire do
  let(:reference_datetime) { DateTime.new(2010, 11, 10) }

  let(:expiration_date) { 2.business_hours.from_now }

  let(:author_1) { create(:person, email: 'test@example.com') }
  let(:author_2) { create(:person, email: 'test2@example.com') }

  let(:commit_1) do
    create(:commit,
           author: author_1,
           state: 'pending',
           authored_at: reference_datetime)
  end
  let(:commit_2) do
    create(:commit,
           author: author_2,
           state: 'pending',
           authored_at: reference_datetime)
  end

  around do |example|
    Timecop.freeze(reference_datetime) { example.run }
  end

  before do
    commit_1.update_column(:expires_at, expiration_date)
    commit_2.update_column(:expires_at, expiration_date)
  end

  it 'returns emails as keys of hash' do
    expect(described_class.new.commits_for_authors.keys).to eq([author_1.email, author_2.email])
  end

  it 'returns two sets of keys and values' do
    expect(described_class.new.commits_for_authors.count).to eq(2)
  end
end
