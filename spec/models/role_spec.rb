require 'spec_helper'

describe Role do

  describe ".admin" do
    it "returns the 'admin' role" do
      Role.admin.name.should eq(Role.new({ name: "admin" }).name)
    end
  end

  describe ".user" do
    it "returns the 'user' role" do
      Role.user.name.should eq(Role.new({ name: "user"}).name)
    end
  end

end
