require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :is_email_validated => false,
      :first_name => "MyString",
      :last_name => "MyString",
      :is_enabled => false,
      :is_deleted => false
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_username", :name => "user[username]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_is_email_validated", :name => "user[is_email_validated]"
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_is_enabled", :name => "user[is_enabled]"
      assert_select "input#user_is_deleted", :name => "user[is_deleted]"
    end
  end
end
