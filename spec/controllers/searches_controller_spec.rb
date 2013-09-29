require 'spec_helper'

describe SearchesController do
  let(:article_search) { double(:article_search, results: search_results) }
  let(:search_results) { [ mock_model(Article) ]}

  before do
    Search::ArticleSearch.stub(:new).with(hash_including(search_params)) { article_search }
  end

  describe "#index" do
    let(:search_params) { { "keywords" => "neat search" } }

    context "default behavior" do
      it "assigns the results ivar" do
        get :index, search_params
        assigns(:articles).should be
      end

      it "renders the search index template" do
        get :index, search_params
        response.should render_template :index
      end
    end
  end
end
