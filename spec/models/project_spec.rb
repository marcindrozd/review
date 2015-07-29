require 'rails_helper'

describe Project do

  it { should respond_to(:commits) }
  it { should respond_to(:tokens) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:url) }

  describe "with project named something" do

    let!(:project){ described_class.create(name: 'something', url: 'http://test.com') }

    it "doesnt let me create new project with the same name" do
      expect do
        described_class.create(name: project.name)
      end.not_to change{ described_class.all.count }
    end

    it "has uniq token generated" do
      expect(project.tokens.first).not_to be_nil
    end

  end
end
