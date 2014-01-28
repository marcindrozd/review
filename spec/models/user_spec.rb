require 'spec_helper'

describe User do

  it { should respond_to(:permissions) }
  it { should respond_to(:admin) }

end
