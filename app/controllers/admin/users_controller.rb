class Admin::UsersController < ApplicationController
  before_action :login_request
  before_action :authorization_check
  before_action :set_user, only: [:edit, :show, :update, :change_role, :destroy]

  def index
    @users = User.all.order(role: :desc).page(params[:page]).per(10)
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

  def change_role
    @user.role = role_value
    if @user.save(validate: false)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      redirect_to admin_users_path, alert: 'Failed to change role.'
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

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :role
                                 )
  end

  def role_value
    params.permit(:change_role)[:change_role]
  end
end
