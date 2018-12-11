class Admin::UsersController < ApplicationController
  before_action :user_confirmation
  before_action :set_user, only: [:edit, :show, :update, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @own_tasks = Task.where(user_id: @user.id).page(params[:page]).per(5)
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to ({:controller => 'admin/users', :action => 'index'}), :notice => 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_confirmation
    redirect_to root_path unless logged_in?
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation
                                 )
  end
end
