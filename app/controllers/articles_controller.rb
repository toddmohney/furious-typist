class ArticlesController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @articles = Article.published.order("created_at DESC")
  end

  def show
    set_flash_message if current_user.present? && current_user.is_admin?
  end

  def create
    @article.author = current_user

    if @article.save
      redirect_to @article, :alert => 'Article was successfully created.'
    else
      render_article_errors_flash
      render :action => "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to @article, :alert => 'Article was successfully updated.'
    else
      render_article_errors_flash
      render :action => "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url
  end

  private

  def render_article_errors_flash
    error_message = "There are #{@article.errors.count} errors which need to be corrected"
    flash[:error] = error_message
  end

  def set_flash_message
    if @article.published?
      flash[:notice] = "You are viewing a published article"
    elsif
      flash[:notice] = "You are viewing this article in preview mode. This article has not been published"
    end
  end
end
