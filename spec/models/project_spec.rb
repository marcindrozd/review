require 'spec_helper'

describe Project do

  it { should respond_to(:commits) }
  it { should respond_to(:permissions) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:url) }
  it { should validate_uniqueness_of(:token) }

  describe "with project named something" do

    let!(:project){ Project.create(name: 'something', url: 'http://test.com') }

    it "should not let me create new project with the same name" do
      expect do
        Project.create(name: project.name)
      end.not_to change{ Project.all.count }
    end

    it "should have uniq token generated" do
      expect(project.token).not_to be_nil
    end

  end
end
