require 'spec_helper'

include Devise::TestHelpers


describe ArticlesController, :type => :controller do
  # controller_macros.rb

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "url" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ArticlesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    before :each do
      @test_article = FactoryGirl.create(:article)
      get :index, {}, valid_session
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
      get :show, {:id => @test_article.to_param}, valid_session
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
      get :new, {}, valid_session
      assigns(:article).should be_a_new(Article)
    end

    it "should render the new template" do
      get :new, {}, valid_session
      expect(response).to render_template("new")
    end
  end



  describe "GET edit" do
    it "assigns the requested article as @article" do
      article = FactoryGirl.create(:article)
      get :edit, {:id => article.to_param}, valid_session
      assigns(:article).should eq(article)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Article" do
        expect {
        post :create, {
            :article => {
                :body => "test body",
                :title => "test title",
                :url => "http://www.someurl.com",
                :category => "tech",
                :tags => "ok,hi,no,bye"
            }
        }, valid_session
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {
            :article => {
                :body => "test body",
                :title => "test title",
                :url => "http://www.someurl.com",
                :category => "tech",
                :tags => "ok,hi,no,bye"
            }
        }, valid_session
        assigns(:article).should be_a(Article)
        assigns(:article).should be_persisted
      end

      it "redirects to the created article" do
        post :create, {
            :article => {
                :body => "test body",
                :title => "test title",
                :url => "http://www.someurl.com",
                :tags => "ok,what,now,super",
                :category => "tech"
            }
        }, valid_session
        response.should redirect_to(Article.last)
      end
    end


    describe "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        post :create, {:article => { "url" => "invalid value" }}, valid_session
        assigns(:article).should be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        post :create, {:article => { "url" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested article" do
        article = articles(:test)
        # Assuming there are no other articles in the database, this
        # specifies that the Article created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Article.any_instance.should_receive(:update_attributes).with({ "category" => nil, "tags" => [], "url" => "MyString" })
        put :update, {:id => article.to_param, :article => { "url" => "MyString" }}, valid_session
      end

      it "assigns the requested article as @article" do
        article = articles(:test)
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        assigns(:article).should eq(article)
      end

      it "redirects to the article" do
        article = articles(:test)
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        response.should redirect_to(article)
      end
    end

    describe "with invalid params" do
      it "assigns the article as @article" do
        article = articles(:test)
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        put :update, {:id => article.to_param, :article => { "url" => "invalid value" }}, valid_session
        assigns(:article).should eq(article)
      end

      it "re-renders the 'edit' template" do
        article = articles(:test)
        # Trigger the behavior that occurs when invalid params are submitted
        Article.any_instance.stub(:save).and_return(false)
        put :update, {:id => article.to_param, :article => { "url" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end


  describe "DELETE destroy" do
    it "destroys the requested article" do
      article = articles(:test)
      expect {
        delete :destroy, {:id => article.to_param}, valid_session
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      article = articles(:test)
      delete :destroy, {:id => article.to_param}, valid_session
      response.should redirect_to(articles_url)
    end
  end
end
