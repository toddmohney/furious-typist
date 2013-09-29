require 'spec_helper'

describe Role do

  describe ".admin" do
    let(:admin_role) { double(:admin_role) }

    before do
      Role.stub(:find_or_create_by_name).with("admin") { admin_role }
    end

    it "returns the 'admin' role" do
      Role.admin.should eq(admin_role)
    end
  end

  describe ".user" do
    let(:user_role) { double(:user_role) }

    before do
      Role.stub(:find_or_create_by_name).with("user") { user_role }
    end

    it "returns the 'user' role" do
      Role.user.should eq(user_role)
    end
  end

end
