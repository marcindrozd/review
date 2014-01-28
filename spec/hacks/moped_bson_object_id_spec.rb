require 'spec_helper'

describe Moped::BSON::ObjectId do

  let(:id) { described_class.new }

  it "serializes to string" do
    expect(id.as_json).to be_kind_of String
  end
end
