require 'spec_helper'

describe Invitation do
  let(:invitation) { described_class.create(email: 'test@test.com') }

  it { should belong_to :sender }
  it { should belong_to :recipient }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  it 'generates token before user is created' do
    expect(invitation.token).not_to be_empty
  end
end
