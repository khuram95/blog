class TagsController < ApplicationController

  before_action :require_admin, except:[:index, :show]

  def index
    @tags = Tag.paginate(page: params[:page], per_page: 5)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    if @tag.save
      flash[:success] = "Tag successfully created"
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @tag_articles = @tag.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:success] = "Tag name was successfully updated"
      redirect_to tag_path(@tag)
    else
      render 'edit'
    end
  end

  private
  def tag_params
    params.require('tag').permit('name')
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "Only admins can perform this action"
      redirect_to tags_path
    end  
  end

end
