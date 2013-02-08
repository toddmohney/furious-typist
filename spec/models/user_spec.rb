require 'spec_helper'

describe User do
  fixtures :users


  it "fails validation without a username" do
    expect(User.new).to have(1).error_on(:username)
  end

  it "fails validation on a whitespace-only username" do
    expect(User.new({ :username => ' ' })).to have(1).error_on(:username)
  end

  it "fails validation without an email address" do
    expect(User.new).to have(1).error_on(:email)
  end

  it "passes validation with a username" do
    @user = User.new({ :username => 'toddmohney' })
    expect(@user).to have(0).errors_on(:username)
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