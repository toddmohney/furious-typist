require 'spec_helper'

describe Tag do
  fixtures :tags

  it "fails validation without a name" do
    expect(Tag.new).to have(1).error_on(:name)
  end

  it "fails validation with a whitespace-only name" do
    expect(Tag.new({ :name => ' ' })).to have(1).error_on(:name)
  end

  it "passes validation with a valid name" do
    expect(Tag.new({ :name => 'new post' })).to have(0).errors
  end

  it "has a valid testing fixture" do
    @tag = tags(:neat_post)
    expect(@tag).to have(0).errors
  end
end
