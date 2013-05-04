class SearchesController < ApplicationController
  ITEMS_PER_PAGE = 10

  def index
    search = Search::ArticleSearch.new(params)
    @articles = search.results
  end

end
