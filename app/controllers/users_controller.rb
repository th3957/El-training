class UsersController < ApplicationController
  before_action :login_request, except: [:new, :create]

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def new
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      redirect_to user_path(@user)
    else
      @user = User.new
    end
  end

  def show
    if User.find_by_id(params[:id]).nil?
      redirect_to root_path
    else
      @user = User.find(params[:id])
      redirect_to root_path unless @user.id == current_user.id
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation
                                 )
  end
end
