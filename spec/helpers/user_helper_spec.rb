require 'spec_helper'

describe UserHelper do
  let(:user) { double(:user, is_admin?: user_is_admin )}

  describe "#show_role" do
    context "when the user is an admin" do
      let(:user_is_admin) { true }

      it "shows the 'admin' role" do
        helper.show_role(user).should == "admin"
      end
    end

    context "when the user is not an admin" do
      let(:user_is_admin) { false }

      it "does not display a role" do
        helper.show_role(user).should == ""
      end
    end
  end
end
