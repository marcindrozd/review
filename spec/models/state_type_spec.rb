require 'rails_helper'

RSpec.describe StateType do
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
