class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(params[:tag])

    if @tag.save
      redirect_to @tag, :notice => 'Tag was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
      redirect_to @tag, :notice => 'Tag was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to tags_url
  end
end
