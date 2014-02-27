require 'spec_helper'

describe Project do

  it { should respond_to(:commits) }
  it { should respond_to(:permissions) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:url) }
  it { should validate_uniqueness_of(:token) }

  describe "with project named something" do

    let!(:project){ Project.create(name: 'something') }

    it "should not let me create new project with the same name" do
      -> { Project.create(name: project.name) }.should_not change{ Project.count }
    end

    it "should have uniq token generated" do
      project.token.should_not be_nil
    end

  end
end
