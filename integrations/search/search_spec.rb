require_relative '../integration_spec_helper'

describe "Searching Articles", search: true do

  it "only returns published articles" do
    unpublished_article = FactoryGirl.create(:unpublished_article, title: "cool unpublished article", body: "cool unpublished body")
    published_article = FactoryGirl.create(:published_article, title: "cool published article", body: "cool published body")

    search = Search::ArticleSearch.new({ keywords: "cool" })

    expect(search.results.count).to eq(1)
    expect(search.results.first.title).to eq(published_article.title)
    expect(search.results.first.body).to eq(published_article.body)
  end

end
