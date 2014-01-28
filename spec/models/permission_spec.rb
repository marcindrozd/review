require 'spec_helper'

describe Permission do

  it { should respond_to(:project) }
  it { should respond_to(:user) }
  it { should respond_to(:allowed) }

  describe "create" do
    let!(:project){ Project.create() }
    let!(:user){ User.create() }

    it "should set correct allowed" do
      premission = Permission.create(user: user, project: project)
      premission.allowed.should be_false
    end

    context "should not let me create new permission" do
      it 'with the same project and user' do
        Permission.create(user: user, project: project)
        -> { Permission.create(user: user, project: project) }.should_not change{ Permission.count }
      end

      it 'without project' do
        -> { Permission.create(user: user) }.should_not change{ Permission.count }
      end

    end
  end
end
