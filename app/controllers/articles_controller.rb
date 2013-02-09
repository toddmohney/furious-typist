class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
    @category_name = ""

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @category_name = @article.category.name unless @article.category.blank?
  end

  # POST /articles
  # POST /articles.json
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

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, :notice => 'Article was successfully created.' }
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
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
    end

    unless params[:article][:category] == nil || params[:article][:category].empty?
      @category_name = params[:article][:category]

      # parse the category from the params
      @category = Category.find_or_create_by_name(@category_name.downcase)
    end

    # replace the tags attribute in params
    params[:article][:category] = @category
    params[:article][:tags] = @tags

    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, :notice => 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def ajaxcall
    p = params[:ok]

    respond_to do |format|
      format.json { render :json => { :hi => "hey", :data => p }}
    end
  end
end
