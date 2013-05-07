class ArticlesController < ApplicationController
  load_and_authorize_resource :only => [:show, :new, :edit]

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @articles = Article.published.order("created_at DESC")
  end

  def show
    set_flash_message if current_user.present? && current_user.is_admin?
  end

  def new
    @category_name = ""
  end

  def edit
    @category_name = @article.category.name unless @article.category.blank?
  end

  def create
    params[:article][:tags] = parse_tags(params[:article][:tags])
    params[:article][:category] = parse_category(params[:article][:category])

    @article = Article.new(params[:article])
    @article.author = current_user

    if @article.save
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

  private

  def set_flash_message
    if @article.published?
      flash[:alert] = "You are viewing a published article"
    elsif
      flash[:alert] = "You are viewing this article in preview mode. This article has not been published"
    end
  end

  def parse_tags(tags_string)
    tags = []

    unless tags_string.blank?
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
