require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :is_email_validated => false,
      :first_name => "MyString",
      :last_name => "MyString",
      :is_enabled => false,
      :is_deleted => false
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
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
