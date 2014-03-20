require 'spec_helper'

describe GithubHookParser::ProjectOwner do

  describe "parsing basic values" do

    let(:owner_parser) { described_class.new email: 'test@example.com', name: 'example_name' }

    it "returns email" do
      expect(owner_parser.email).to eq 'test@example.com'
    end

    it "returns name" do
      expect(owner_parser.name).to eq 'example_name'
    end

  end

end
