class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  before_action :user_confirmation

  def index
    if params[:task].present? && params[:task][:search].present?
      @tasks = Task.search(
        params[:task][:title],
        params[:task][:status],
        params[:task][:priority]
      )
    elsif params[:sort].present?
      @tasks = Task.sort(params[:sort])
    else
      params[:sort] = "0"
      @tasks = Task.sort(params[:sort])
    end
    @tasks = @tasks.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: 'Task was successfully deleted.'
  end

  private

  def set_task
    if Task.find_by_id(params[:id]).nil?
      redirect_to root_path
    else
      @task = Task.find(params[:id])
    end
  end

  def user_confirmation
    redirect_to root_path unless logged_in?
  end

  def task_params
    params.require(:task).permit(:title,
                                 :status,
                                 :priority,
                                 :deadline,
                                 :contents
                                 )
  end
end
