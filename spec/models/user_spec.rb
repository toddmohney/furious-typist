require 'spec_helper'

describe User do
  describe "validation" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should ensure_length_of(:username).is_at_most(64) }
  end

  describe "callbacks" do
    describe "after_initialize" do
      let(:user_role) { double(:user_role) }
      let(:user_roles) { [] }

      before do
        Role.stub(:where).with({ name: "user" }) { user_role }
        User.any_instance.stub(:roles) { user_roles }
      end

      it "adds the default 'user' role" do
        user = User.new
        user.roles.should == [ user_role ]
      end
    end
  end
end


