class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followings, :followers, :likes]
  
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  def index
     @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @pagy, @favorites = pagy(@user.favorites_list)
    @microposts = @user.favorites_list
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
