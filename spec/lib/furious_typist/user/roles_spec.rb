require 'spec_helper'

describe User::Roles do
  class TestClass
    include ActiveModel::Validations
    include User::Roles
    attr_accessor :roles

    def initialize
      @roles = []
    end
  end

  describe "#add_role" do
    context "the object does not already have the role" do
      let(:role) { double(:role) }

      it "should add the role to the object" do
        test_class = TestClass.new
        test_class.roles.should_receive(:<<).with(role)
        test_class.add_role(role)
      end
    end

    context "the user already has the role" do
      let(:role) { double(:role) }

      it "should not add the role to the user" do
        test_class = TestClass.new
        test_class.roles = [ role ]
        test_class.roles.should_not_receive(:<<)
        test_class.add_role(role)
      end
    end
  end

  describe "#remove_role" do
    let(:role) { double(:role, name: "role_name") }
    let(:roles) { double(:roles) }

    it "removes the given role from the user" do
      test_class = TestClass.new
      test_class.roles = [ role ]
      test_class.roles.stub(:where).with(name: role.name) { [role] }
      test_class.roles.should_receive(:delete).with([role])
      test_class.remove_role(role.name)
    end
  end

  describe "#is_admin?" do
    context "user is not an admin" do
      it "should return false" do
        test_class = TestClass.new
        test_class.is_admin?.should be_false
      end
    end

    context "user is an admin" do
      let(:admin_role) { double(:admin_role) }

      before do
        Role.stub(:admin) { admin_role }
      end

      it "should return true" do
        test_class = TestClass.new
        test_class.roles = [admin_role]
        test_class.is_admin?.should be_true
      end
    end
  end

  describe "#is_admin" do
    let(:admin_role) { double(:admin_role, name: "admin") }

    before do
      Role.stub(:admin) { admin_role }
    end

    context "when setting the admin role" do
      context "when the user is not an admin" do
        it "adds the admin role" do
          test_class = TestClass.new
          test_class.is_admin = true
          test_class.is_admin?.should be_true
        end
      end

      context "when the user is already an admin" do
        it "does not duplicate and existing admin role" do
          test_class = TestClass.new
          test_class.roles = [admin_role]
          test_class.roles.should_not_receive(:<<).with(admin_role)
          test_class.is_admin = true
        end
      end
    end

    context "when removing the admin role" do
      it "removes the admin role" do
        test_class = TestClass.new
        test_class.roles = [admin_role]
        test_class.roles.stub(:where).with(name: "admin") { [admin_role] }
        test_class.roles.should_receive(:delete).with([admin_role])
        test_class.is_admin = false
      end
    end
  end
end
