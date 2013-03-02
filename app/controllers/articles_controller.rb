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
    params[:article][:tags] = parse_tags(params[:article][:tags])
    params[:article][:category] = parse_category(params[:article][:category])

    @article = Article.new(params[:article])

    if @article.save
      expire_action :action => [:index, :show]
      redirect_to @article, :notice => 'Article was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    params[:article][:tags] = parse_tags(params[:article][:tags])
    params[:article][:category] = parse_category(params[:article][:category])

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

  private

    def parse_tags(tags_string)
      tags = []

      unless tags_string == nil || tags_string.empty?
        tag_list = tags_string.split(',')

        tag_list.each do |tag|
          unless tag.empty?
            tags << Tag.find_or_create_by_name(tag.downcase)
          end
        end
      end

      tags
    end

    def parse_category(category_string)
      category = nil

      unless category_string.blank?
        category = Category.find_or_create_by_name(category_string.downcase)
      end

      category
    end
end
