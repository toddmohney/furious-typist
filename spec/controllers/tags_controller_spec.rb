require 'spec_helper'

describe TagsController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Tag. As you add validations to Tag, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "name" => "MyString" }
  end

  describe "GET index" do
    it "assigns all tags as @tags" do
      tag = FactoryGirl.create(:tag)
      get :index, {}
      assigns(:tags).include?(tag).should eq(true)
    end

    it "renders the index template" do
      tag = FactoryGirl.create(:tag)
      get :index, {}
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns the requested tag as @tag" do
      tag = FactoryGirl.create(:tag)
      get :show, {:id => tag.to_param}
      assigns(:tag).should eq(tag)
    end

    it "renders the show template" do
      tag = FactoryGirl.create(:tag)
      get :show, {:id => tag.to_param}
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "assigns a new tag as @tag" do
      get :new, {}
      assigns(:tag).should be_a_new(Tag)
    end

    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    it "assigns the requested tag as @tag" do
      tag = FactoryGirl.create(:tag)
      get :edit, {:id => tag.to_param}
      assigns(:tag).should eq(tag)
    end

    it "renders the edit template" do
      tag = FactoryGirl.create(:tag)
      get :edit, {:id => tag.to_param}
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, {:tag => valid_attributes}
        }.to change(Tag, :count).by(1)
      end

      it "assigns a newly created tag as @tag" do
        post :create, {:tag => valid_attributes}
        assigns(:tag).should be_a(Tag)
        assigns(:tag).should be_persisted
      end

      it "redirects to the created tag" do
        post :create, {:tag => valid_attributes}
        response.should redirect_to(Tag.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tag as @tag" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tag.any_instance.stub(:save).and_return(false)
        post :create, {:tag => { "name" => "invalid value" }}
        assigns(:tag).should be_a_new(Tag)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Tag.any_instance.stub(:save).and_return(false)
        post :create, {:tag => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tag" do
        tag = FactoryGirl.create(:tag)
        # Assuming there are no other tags in the database, this
        # specifies that the Tag created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Tag.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => tag.to_param, :tag => { "name" => "MyString" }}
      end

      it "assigns the requested tag as @tag" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => valid_attributes}
        assigns(:tag).should eq(tag)
      end

      it "redirects to the tag" do
        tag = FactoryGirl.create(:tag)
        put :update, {:id => tag.to_param, :tag => valid_attributes}
        response.should redirect_to(tag)
      end
    end

    describe "with invalid params" do
      it "assigns the tag as @tag" do
        tag = FactoryGirl.create(:tag)
        # Trigger the behavior that occurs when invalid params are submitted
        Tag.any_instance.stub(:save).and_return(false)
        put :update, {:id => tag.to_param, :tag => { "name" => "invalid value" }}
        assigns(:tag).should eq(tag)
      end

      it "re-renders the 'edit' template" do
        tag = FactoryGirl.create(:tag)
        # Trigger the behavior that occurs when invalid params are submitted
        Tag.any_instance.stub(:save).and_return(false)
        put :update, {:id => tag.to_param, :tag => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tag" do
      tag = FactoryGirl.create(:tag)
      expect {
        delete :destroy, {:id => tag.to_param}
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the tags list" do
      tag = FactoryGirl.create(:tag)
      delete :destroy, {:id => tag.to_param}
      response.should redirect_to(tags_url)
    end
  end

end
