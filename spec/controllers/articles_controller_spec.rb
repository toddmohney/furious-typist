require 'spec_helper'

describe ArticlesController, :type => :controller do
  login_admin

  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to
  # update the return value of this method accordingly.

  describe "GET index" do
    before :each do
      @test_article = FactoryGirl.create(:article)
      get :index, {}
    end
    
    it "assigns all articles as @articles" do
      assigns(:articles).should include @test_article
    end

    it "renders the index template" do
      expect(response).to render_template("index")  
    end
  end

  describe "GET show" do
    before :each do
      @test_article = FactoryGirl.create(:article)
      get :show, {:id => @test_article.to_param}
    end
    
    it "assigns the requested article as @article" do
      assigns(:article).should eq(@test_article)
    end

    it "should render the show template" do
      expect(response).to render_template("show")
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
    describe "with valid params" do
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

      it "redirects to the created article" do
        post :create, {:article => FactoryGirl.attributes_for(:article_post_params)}
        response.should redirect_to(Article.last)
      end
    end

    describe "with invalid params" do
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
