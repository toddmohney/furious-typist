require 'spec_helper'

describe User do
  fixtures :users


  it "fails validation without a username" do
    expect(User.new).to have(1).error_on(:username)
  end

  it "fails validation on a whitespace-only username" do
    expect(User.new({ :username => ' ' })).to have(1).error_on(:username)
  end

  it "passes validation with a username" do
    @user = User.new({ :username => 'toddmohney' })
    expect(@user).to have(0).errors_on(:username)
  end

  it "fails validation without an email address" do
    expect(User.new).to have(1).error_on(:email)
  end

  it "passes validation with an email address" do
    @user = User.new({ :email => 'toddmohney@gmail.com' })
    expect(@user).to have(0).errors_on(:email)
  end

  it "passes validation with a valid username and email address" do
    @user = User.new({ :username => "toddmohney",
                       :email => "toddmohney@gmail.com" })
    expect(@user).to have(0).errors
  end

  it "passes validation without a first name and without a last name" do
    @user = User.new({ :username => "toddmohney",
                       :email => "toddmohney@gmail.com" })
    expect(@user).to have(0).error
  end

  it "fails validation with a first name, but no last name" do
    @user = User.new({ :username => "toddmohney",
                       :email => "toddmohney@gmail.com",
                       :first_name => "todd" })
    expect(@user).to have(1).error_on(:last_name)
  end

  it "fails validation with a last name, but no first name" do
    @user = User.new({ :username => "toddmohney",
                       :email => "toddmohney@gmail.com",
                       :last_name => "mohney"})
    expect(@user).to have(1).error_on(:first_name)
  end

  it "passes validation with a first and last name" do
    @user = User.new({ :username => "toddmohney",
                       :email => "toddmohney@gmail.com",
                       :first_name => "todd",
                       :last_name => "mohney"})
    expect(@user).to have(0).errors
  end

  it "passes validation using a valid fixture" do
    @user = users(:todd)
    expect(@user).to have(0).errors
  end
end


describe User, "#full_name" do
  fixtures :users

  it "returns the user's first name, a space, then last name" do
    @user = users(:todd)
    expect(@user.full_name).to eq('todd mohney')
  end
end