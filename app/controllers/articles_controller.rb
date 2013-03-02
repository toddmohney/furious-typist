class ArticlesController < ApplicationController
  load_and_authorize_resource :only => [:new, :edit]

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  caches_action [:index, :show]

  def index
    @articles = Article.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @category_name = ""
  end

  def edit
    @article = Article.find(params[:id])
    @category_name = @article.category.name unless @article.category.blank?
  end

  def create
    @category = nil
    @tags = []

    unless params[:article][:category] == nil || params[:article][:category].empty?
      @category_name = params[:article][:category]

      # parse the category from the params
      @category = Category.find_or_create_by_name(@category_name.downcase)
    end

    unless params[:article][:tags] == nil || params[:article][:tags].empty?
      # parse the tags from the params
      # convert spaces to a comma delimited string
      @tag_list = params[:article][:tags].split(',')

      @tag_list.each do |tag|
        unless tag.empty?
          @tags << Tag.find_or_create_by_name(tag.downcase)
        end
      end
    end

    # replace the tags attribute in params
    params[:article][:category] = @category
    params[:article][:tags] = @tags

    @article = Article.new(params[:article])

    if @article.save
      expire_action :action => [:index, :show]
      redirect_to @article, :notice => 'Article was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    # init tag list
    @category = nil
    @tags = []

    unless params[:article][:tags] == nil || params[:article][:tags].empty?
      # parse the tags from the params
      @tag_list = params[:article][:tags].split(',')

      @tag_list.each do |tag|
        unless tag.blank?
          @tags << Tag.find_or_create_by_name(tag.downcase)
        end
      end

      params[:article][:tags] = @tags
    end

    unless params[:article][:category] == nil || params[:article][:category].empty?
      @category_name = params[:article][:category]
      # parse the category from the params
      @category = Category.find_or_create_by_name(@category_name.downcase)
      # replace the tags attribute in params
      params[:article][:category] = @category
    end

    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      expire_action :action => [:index, :show]
      redirect_to @article, :notice => 'Article was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_url
  end

  def ajaxcall
    p = params[:ok]

    respond_to do |format|
      format.json { render :json => { :hi => "hey", :data => p }}
    end
  end
end
