require 'spec_helper'

describe User do
  describe "validation" do
    it "fails validation without a username" do
      expect(User.new).to have(1).error_on(:username)
    end

    it "fails validation on a whitespace-only username" do
      expect(User.new({ :username => ' ' })).to have(1).error_on(:username)
    end

    it "passes validation with a username" do
      user = User.new({ :username => 'toddmohney' })
      user.should have(0).errors_on(:username)
    end

    it "fails validation without an email address" do
      User.new.should have(2).errors_on(:email)
    end

    it "passes validation with an email address" do
      user = User.new({ :email => 'toddmohney@gmail.com' })
      user.should have(0).errors_on(:email)
    end

    it "passes validation with a valid username and email address" do
      user = User.new({ :username => "toddmohney",
                        :email => "toddmohney@gmail.com" })
      user.should have(0).errors
    end

    it "passes validation without a first name and without a last name" do
      user = User.new({ :username => "toddmohney",
                        :email => "toddmohney@gmail.com" })
      user.should have(0).error
    end

    it "fails validation with a first name, but no last name" do
      user = User.new({ :username => "toddmohney",
                        :email => "toddmohney@gmail.com",
                        :first_name => "todd" })
      user.should have(1).error_on(:last_name)
    end

    it "fails validation with a last name, but no first name" do
      user = User.new({ :username => "toddmohney",
                        :email => "toddmohney@gmail.com",
                        :last_name => "mohney"})
      user.should have(1).error_on(:first_name)
    end

    it "fails validation with invalid characters in the first name" do
      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "t.o.d.d",
                        :last_name => "mohney"
      })

      user.should have(1).error_on(:first_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "12345",
                        :last_name => "mohney"
      })

      user.should have(1).error_on(:first_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "t.5",
                        :last_name => "mohney"
      })

      user.should have(1).error_on(:first_name)
    end

    it "fails validation with invalid characters in the last name" do
      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "todd",
                        :last_name => "moh&ney"
      })

      user.should have(1).error_on(:last_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "todd",
                        :last_name => "moh5ey"
      })

      user.should have(1).error_on(:last_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "todd",
                        :last_name => "234."
      })

      user.should have(1).error_on(:last_name)
    end

    it "fails validation if the first name is < 2 or > 64 chars" do
      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "t",
                        :last_name => "mohney."
      })

      user.should have(1).error_on(:first_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                        :last_name => "mohney."
      })

      user.should have(1).error_on(:first_name)
    end

    it "fails validation if the last name is < 2 or > 64 chars" do
      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "todd",
                        :last_name => "m."
      })

      user.should have(1).error_on(:last_name)

      user = User.new({ :username => "some_new_user",
                        :email => "test.test.com",
                        :first_name => "todd",
                        :last_name => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx."
      })

      user.should have(1).error_on(:last_name)
    end

    it "passes validation with a first and last name" do
      user = User.new({ :username => "toddmohney",
                        :email => "toddmohney@gmail.com",
                        :first_name => "todd",
                        :last_name => "mohney"})
      user.should have(0).errors
    end
  end

  describe "factories" do
    it "has a valid factory" do
      user = FactoryGirl.create(:user)
      user.should be_valid
    end
  end

  # test method 'full_name'
  describe "#full_name" do
    let(:user) do
      stub_model User, :first_name => "todd", :last_name => "mohney"
    end

    it "returns the user's first name, a space, then last name" do
      user.full_name.should eq("todd mohney")
    end
  end

  describe "#add_role" do
    context "the user does not already have the role" do
      it "should add the role to the user" do
        user = User.new({ username: Faker::Name.name,
                          email: Faker::Internet.email })

        role_count = user.roles.length
        user.add_role(Role.admin)

        user.roles.include?(Role.admin).should eq(true)
        user.roles.length.should eq(role_count + 1)
      end
    end

    context "the user already has the role" do
      let(:first_role) do
        stub_model(Role)
      end

      it "should not add the role to the user" do
        user = User.new({ username: Faker::Name.name,
                          email: Faker::Internet.email })

        user.add_role(first_role)
        role_count = user.roles.length
        user.add_role(first_role)

        user.roles.include?(first_role).should eq(true)
        user.roles.length.should eq(role_count)
      end
    end
  end

  describe "#remove_role" do
    let(:user) { users(:admin) }

    it "removes the given role from the user" do
      user.roles.count.should == 2

      user.remove_role("admin")
      user.roles.count.should == 1
    end
  end

  describe "#is_admin?" do
    context "user is not an admin" do
      it "should return false" do
        user = User.new({ username: Faker::Name.name, email: Faker::Internet.email })
        user.is_admin?.should be_false
      end
    end

    context "user is an admin" do
      it "should return true" do
        user = User.new({ username: Faker::Name.name,
                          email: Faker::Internet.email })
        user.add_role(Role.admin)

        user.is_admin?.should be_true
      end
    end
  end

  describe "#is_admin" do
    context "when setting the admin role" do
      context "when the user is not an admin" do
        let(:user) { users(:user) }

        it "adds the admin role" do
          expect {
            user.is_admin = true
          }.to change{ user.roles.count }.by(1)

          user.roles.should include(Role.find_by_name("admin"))
        end
      end

      context "when the user is already an admin" do
        let(:user) { users(:admin) }

        it "does not duplicate and existing admin role" do
          expect {
            user.is_admin = true
          }.to change{ user.roles.count }.by(0)
        end
      end
    end

    context "when removing the admin role" do
      let(:user) { users(:admin) }

      it "removes the admin role" do
        expect {
          user.is_admin = false
        }.to change{ user.roles.count }.by(-1)

        user.roles.should_not include(Role.find_by_name("admin"))
      end
    end
  end
end


