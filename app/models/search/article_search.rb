module Search
  class ArticleSearch
    ITEMS_PER_PAGE = 10

    def initialize(options)
      @options = normalize_search_options(options)
      @search = Article.search(keywords) unless keywords.blank?
    end

    def results
      search || Article.published.order("created_at DESC")
    end

    private

    attr_reader :search, :options

    def keywords
      options[:keywords]
    end

    def normalize_search_options(options)
      { keywords: options.fetch(:keywords, "") }
    end

  end
end
