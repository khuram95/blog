class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)   
  end

  def new
    @article = Article.new
  end

  def create
    #article_params[:data] = article_params[:data].read
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Your blog is submitted, thank you!'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Your blog has been successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] ="Article was deleted"
    redirect_to articles_path

  end

private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description,:cover_photo, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only update or delete your own articles"
        redirect_to articles_path
    end 
  end
end