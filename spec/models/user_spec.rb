require 'rails_helper'

describe User do
  it { should respond_to(:tokens) }
  it { should have_one(:invitation) }
  it { should have_many(:sent_invitations) }
end
