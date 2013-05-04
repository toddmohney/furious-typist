module Search
  class ArticleSearch
    ITEMS_PER_PAGE = 10

    def initialize(options)
      options = normalize_search_options(options)

      @search = Article.search do
        fulltext options[:keywords]
        paginate page: options[:page], per_page: ITEMS_PER_PAGE
      end
    end

    def results
      @search.results
    end

    private

    def normalize_search_options(options)
      {
        keywords: options.fetch(:keywords, ""),
        page: options.fetch(:page, 1)
      }
    end

  end
end
