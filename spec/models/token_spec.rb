require 'spec_helper'

describe Token do

  it { should respond_to(:tokenable) }
  it { should validate_uniqueness_of(:value) }

  describe ".get_tokenable" do
    let!(:project){ Project.create(name: 'something', url: 'http://test.com') }
    let!(:token){ project.tokens.first }

    it 'returns nil if no token given' do
      expect(described_class.get_tokenable nil).to be_nil
    end

    it 'returns nil if wrong token given' do
      expect(described_class.get_tokenable 'wrong_token').to be_nil
    end

    it 'returns project if correct token given' do
      expect(described_class.get_tokenable token.value).to eq(project)
    end
  end
end
