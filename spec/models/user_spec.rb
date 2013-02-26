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
end


