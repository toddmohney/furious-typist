require 'spec_helper'

describe SearchesController, search: false do
  describe "#index" do
    let(:search_params) { { "keywords" => "neat search" } }

    context "default behavior" do
      it "assigns the results ivar" do
        get :index, search_params
        assigns(:articles).should be
      end

      it "renders the search index template" do
        get :index
        response.should render_template :index
      end
    end
  end
end

describe SearchesController, search: false do
  context "with valid search params" do
    context "when the page number is not specified" do
      let(:search_params) { { "keywords" => "neat search" } }

      it "should be a search for articles" do
        get :index, search_params
        Sunspot.session.should be_a_search_for(Article)
      end

      it "should be a search for the first page" do
        get :index, search_params
        Sunspot.session.should have_search_params(:paginate, page: 1, per_page: 10) 
      end

      it "should be a search for the keywords" do
        get :index, search_params
        Sunspot.session.should have_search_params(:fulltext, "neat search") 
      end
    end

    context "when the page number is specified" do
      let(:search_params) { { "keywords" => "cool search", "page" => "2" } }

      it "should be a search for the first page" do
        get :index, search_params
        Sunspot.session.should have_search_params(:paginate, page: 2, per_page: 10) 
      end
    end
  end
end

