require 'spec_helper'

describe Category do
  describe "validation" do
    it "fails validation without a name" do
      expect(Category.new).to have(1).error_on(:name)
    end

    it "fails validation without a description" do
      expect(Category.new).to have(1).error_on(:description)
    end

    it "passes validation with a name and description" do
      expect(Category.new({ :name => "test name",
                            :description => "test description" })).to have(0).errors
    end
  end

  describe "factories" do
    it "has a valid factory" do
      FactoryGirl.create(:category).should be_valid
    end
  end
end
