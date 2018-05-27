class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha Blog '#{@user.username}'"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:danger] = "User destroyed with all his articles"
    redirect_to users_path
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if logged_in? and current_user != @user and !current_user.admin?
        flash[:danger] = "You can edit and update only your own profile"
        redirect_to articles_path
      end
    end

    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "only admin users can perform this action"
        redirect_to root_path
    end
  end
end