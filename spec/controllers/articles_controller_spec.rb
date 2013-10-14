require 'spec_helper'

describe ArticlesController, :type => :controller do
  login_admin

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
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let(:article) { stub_model(Article, published: is_published ) }

    before do
      subject.current_user.stub(:is_admin?) { is_admin }

      Article.stub(:find).with(article.id.to_s) { article }
      get :show, { :id => article.id }
    end

    context "when the article is unpublished" do
      let(:is_published) { false }

      context "when logged in as an admin" do
        let(:is_admin) { true }

        it "renders the show template" do
          expect(response).to render_template("show")
        end

        it "renders the 'preview mode' flash message" do
          flash[:notice].should == "You are viewing this article in preview mode. This article has not been published"
        end
      end
    end

    context "when the article is published" do
      let(:is_published) { true }

      context "when logged in as an admin" do
        let(:is_admin) { true }

        it "renders the show template" do
          expect(response).to render_template("show")
        end

        it "renders the 'published mode' flash message" do
          flash[:notice].should == "You are viewing a published article"
        end
      end

      context "when logged in as a user" do
        let(:is_admin) { false }

        it "renders the show template" do
          expect(response).to render_template("show")
        end

        it "does not render a flash message" do
          flash[:notice].should be_nil
        end
      end

      context "when not logged in" do
        let(:is_admin) { false }

        before do
          subject.stub(:current_user) { nil }
        end

        it "renders the show template" do
          expect(response).to render_template("show")
        end

        it "does not render a flash message" do
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
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    it "assigns the requested article as @article" do
      article = FactoryGirl.create(:article)
      get :edit, {:id => article.to_param}
      assigns(:article).should eq(article)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, {:article => FactoryGirl.attributes_for(:article_post_params)}
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {:article => FactoryGirl.attributes_for(:article_post_params)}
        assigns(:article).should be_a(Article)
        assigns(:article).should be_persisted
      end

      it "assigns the current user as the author" do
        post :create, {:article => FactoryGirl.attributes_for(:article_post_params)}
        assigns(:article).author.should == subject.current_user
      end

      it "redirects to the created article" do
        post :create, {:article => FactoryGirl.attributes_for(:article_post_params)}
        response.should redirect_to(Article.last)
      end

      it "creates new tags" do
        post_params = FactoryGirl.attributes_for(:article_post_params)
        tag_count = Tag.count
        new_tags_count = post_params[:tags].split(',').count

        post :create, {:article => post_params}

        Tag.count.should eq(tag_count + new_tags_count)
      end

      it "does not duplicate existing tags" do
        post_params = FactoryGirl.attributes_for(:article_post_params)

        tag = Tag.create({ name: Faker::Lorem.word })
        tag_count = Tag.count

        # replace the :tags in the post_params
        # with known existing tag names
        post_params[:tags] = tag.name

        post :create, {:article => post_params}

        Tag.count.should eq(tag_count)
      end

      it "creates new categories" do
        post_params = FactoryGirl.attributes_for(:article_post_params)

        category_count = Category.count

        category = Category.new({ name: Faker::Lorem.word })
        new_category_count = post_params[:category].split(',').count

        post_params[:category] = category.name
        post :create, {:article => post_params}

        Category.count.should eq(category_count + new_category_count)
      end

      it "does not duplicate existing categories" do
        post_params = FactoryGirl.attributes_for(:article_post_params)

        category = Category.create({ name: Faker::Lorem.word })
        category_count = Category.count

        # replace the :tags in the post_params
        # with known existing tag names
        post_params[:category] = category.name

        post :create, {:article => post_params}

        Category.count.should eq(category_count)
      end
    end

    context "with invalid params" do
      it "sets a flash message" do
        post :create, {:article => { "title" => "invalid value" }}
        expect(flash[:error]).to be
      end

      it "assigns a newly created but unsaved article as @article" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        post :create, {:article => { "title" => "invalid value" }}
        assigns(:article).should be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        post :create, {:article => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before :each do
        @article = FactoryGirl.create(:article)

        @updated_attributes = {
          "body" => "This is the new body",
          "title" => "This is the new title",
          "tags" => [],
          "category" => nil
        }
      end

      it "updates the requested article" do
        # Assuming there are no other articles in the database, this
        # specifies that the Article created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        # updated_article = FactoryGirl.attributes_for(:article_post_params)

        Article.any_instance.should_receive(:update_attributes).with(@updated_attributes)

        put :update, {:id => @article.to_param, :article => @updated_attributes}
      end

      it "assigns the requested article as @article" do
        put :update, {:id => @article.to_param, :article => @updated_attributes}
        assigns(:article).should eq(@article)
      end

      it "redirects to the article" do
        put :update, {:id => @article.to_param, :article => @updated_attributes}
        response.should redirect_to(@article)
      end
    end

    describe "with invalid params" do
      before :each do
        @article = FactoryGirl.create(:article)

        @updated_attributes = {
          "body" => "This is the new body",
          "title" => "This is the new title",
        }
      end

      it "assigns the article as @article" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        put :update, {:id => @article.to_param, :article => { "title" => "invalid value" }}
        assigns(:article).should eq(@article)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        put :update, {:id => @article.to_param, :article => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end


  describe "DELETE destroy" do
    before :each do
      @article = FactoryGirl.create(:article)
    end

    it "destroys the requested article" do
      expect {
        delete :destroy, {:id => @article.to_param}
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, {:id => @article.to_param}
      response.should redirect_to(articles_url)
    end
  end
end
