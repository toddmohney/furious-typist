require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :url => "Url",
        :title => "Title",
        :body => "Body"
      ),
      stub_model(Article,
        :url => "Url",
        :title => "Title",
        :body => "Body"
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "tr>td", :text => "Title".to_s, :count => 2
    # assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
