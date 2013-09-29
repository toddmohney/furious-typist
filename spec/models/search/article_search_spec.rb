require 'spec_helper'

# module Search
  # describe ArticleSearch, search: false do
    # describe "#initialize" do
      # let(:search_params) { { keywords: "cool stuff" }}

      # before do
        # ArticleSearch.new(search_params)
      # end

      # context "default search behavior" do
        # it "should be a search for articles" do
          # Sunspot.session.should be_a_search_for(Article)
        # end

        # it "should be a search for the first page" do
          # Sunspot.session.should have_search_params(:paginate, page: 1, per_page: 10)
        # end

        # it "should be a search for the keywords" do
          # Sunspot.session.should have_search_params(:fulltext, "cool stuff")
        # end
      # end

      # context "when the page number is specified" do
        # let(:search_params) { { keywords: "cool stuff", page: 2 }}

        # it "should be a search for the given page" do
          # Sunspot.session.should have_search_params(:paginate, page: 2, per_page: 10)
        # end
      # end
    # end
  # end
# end
