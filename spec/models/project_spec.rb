require 'spec_helper'

describe Project do

  it { should respond_to(:commits) }
  it { should respond_to(:permissions) }

  describe "with project named something" do

    let!(:project){ Project.create(name: 'something') }

    it "should not let me create new project with the same name" do
      -> { Project.create(name: project.name) }.should_not change{ Project.count }
    end

  end
end
