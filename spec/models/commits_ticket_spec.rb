require 'rails_helper'

describe CommitsTicket do
  it { is_expected.to belong_to :commit }
  it { is_expected.to belong_to :ticket }
end
