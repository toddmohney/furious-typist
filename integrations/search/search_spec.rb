require_relative '../integration_spec_helper'

describe "Searching Articles", search: true do

  it "only returns published articles" do
    unpublished_article = FactoryGirl.create(:unpublished_article, title: "cool unpublished article")
    published_article = FactoryGirl.create(:published_article, title: "cool published article")

    Article.index

    search = Search::ArticleSearch.new({ keywords: "cool" })
    search.results.should == [ published_article ]
  end

end
