require 'spec_helper'

describe ArticlesController, :type => :controller do
  login_admin

  before do
    controller.stub(:authorize!)
  end

  describe "GET index" do
    before :each do
      Article.stub_chain(:published, :order)
    end

    it "displays only published articles" do
      Article.should_receive(:published)
      get :index, {}
    end

    it "displays the published articles in descending order by create date" do
      Article.published.should_receive(:order).with("created_at DESC")
      get :index, {}
    end

    it "renders the index template" do
      get :index, {}
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    let(:article) { double(:article) }
    let(:article_params) do
      {
        id: 123
      }
    end

    before do
      subject.current_user.stub(:is_admin?) { is_admin }

      Article.stub(:find).with(anything) { article }
      article.stub(:published?) { is_published }
    end

    context "when the article is unpublished" do
      let(:is_published) { false }

      context "when logged in as an admin" do
        let(:is_admin) { true }

        it "renders the show template" do
          get :show, article_params
          expect(response).to render_template :show
        end

        it "renders the 'preview mode' flash message" do
          get :show, article_params
          flash[:notice].should == "You are viewing this article in preview mode. This article has not been published"
        end
      end
    end

    context "when the article is published" do
      let(:is_published) { true }

      context "when logged in as an admin" do
        let(:is_admin) { true }

        it "renders the show template" do
          get :show, article_params
          expect(response).to render_template :show
        end

        it "renders the 'published mode' flash message" do
          get :show, article_params
          flash[:notice].should == "You are viewing a published article"
        end
      end

      context "when logged in as a user" do
        let(:is_admin) { false }

        it "renders the show template" do
          get :show, article_params
          expect(response).to render_template :show
        end

        it "does not render a flash message" do
          get :show, article_params
          flash[:notice].should be_nil
        end
      end

      context "when not logged in" do
        let(:is_admin) { false }

        before do
          subject.stub(:current_user) { nil }
        end

        it "renders the show template" do
          get :show, article_params
          expect(response).to render_template :show
        end

        it "does not render a flash message" do
          get :show, article_params
          flash[:notice].should be_nil
        end
      end
    end
  end

  describe "GET new" do
    it "assigns a new article as @article" do
      get :new, {}
      assigns(:article).should be_a_new(Article)
    end

    it "should render the new template" do
      get :new, {}
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:current_user) { double(:current_user) }
    let(:article_params) do
      {
        title: "article title",
        body: "article body",
        published: "true"
      }
    end

    before do
      Article.any_instance.stub(:save) { true }
      Article.any_instance.stub(:author=)

      subject.stub(:current_user) { current_user }
    end

    it "sets the author to the current user" do
      Article.any_instance.should_receive(:author=).with(current_user)
      post :create, article_params
    end

    context "successful save" do
      # it "redirects to the article's show page" do
        # post :create, article_params
        # expect(response).to redirect_to :show
      # end
    end

    context "unsuccessful save" do
      before do
        Article.any_instance.stub(:save) { false }
      end

      it "renders the 'new' template" do
        post :create, article_params
        expect(response).to render_template :new
      end

      it "sets a flash message" do
        post :create, article_params
        expect(flash[:error]).to be
      end
    end
  end

  # TODO: fix this route
  # describe "PUT update" do
    # let(:article) { double(:article) }
    # let(:article_params) do
      # {
        # "article" => {
          # "id" => 1,
          # "title" => "article title",
          # "body" => "article body",
          # "published" => "true"
        # }
      # }
    # end

    # before do
      # article.stub(:update_attributes).
        # with(:article_params).
        # and_return(true)
    # end

    # context "successful update" do
      # it "redirects to the article' show page" do
        # put :update, article_params
        # expect(response).to render_template :show
      # end

      # it "renders flash[:alert]" do
        # put :update, article_params
        # expect(flash[:alert]).to be
      # end
    # end

    # context "unsuccessful update" do
      # before do
        # article.stub(:update_attributes).
          # with(:article_params).
          # and_return(false)
      # end

      # it "renders the 'edit' action" do
        # put :update, article_params
        # expect(response).to render_template :edit
      # end

      # it "sets a flash message" do
        # put :update, article_params
        # expect(flash[:error]).to be
      # end
    # end
  # end


  describe "DELETE destroy" do
    let(:article) { double(:article) }
    let(:article_params) do
      {
        id: 123
      }
    end

    before do
      Article.stub(:find) { article }
      article.stub(:destroy)
    end

    it "deletes the article" do
      article.should_receive(:destroy)
      delete :destroy, article_params
    end

    it "redirects to the index page" do
      delete :destroy, article_params
      expect(response).to redirect_to articles_url
    end
  end
end
