class UsersController < ApplicationController
 
  
  before_action :set_user, only: [:show, :edit, :update]
 
  before_action :set_login, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def followings
   @user = User.find(params[:id])
   @followings = @user.following_users
  end
 
  def followers
   @user = User.find(params[:id])
   @followers = @user.follower_users
  end
 
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @user.update(user_params)
     redirect_to user_path(current_user) , notice: 'ユーザーを編集しました'
    else
     render 'edit'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                               :password_confirmation,
                               :profile, :area)
    # ストロングパラメータにprofileとareaも追加しなければなりません。
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_login
    redirect_to root_url if @user != current_user  
  end

end