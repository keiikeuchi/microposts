class UsersController < ApplicationController
 
  # before_actionを書く順序が大切です。set_userしてからでないと
  # set_loginメソッド内で@userが空になってしまいます。
  before_action :set_user, only: [:show, :edit, :update]
  # ↑showアクションも同じコードがあるので追加しました。
  before_action :set_login, only: [:edit, :update]
  
  
  def show 
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