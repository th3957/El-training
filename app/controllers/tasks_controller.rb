class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  before_action :user_confirmation

  def index
    if params[:sort_status].present?
      @tasks = Task.with_no_progress
    elsif params[:sort_priority].present?
      @tasks = Task.with_highest_priority
    elsif params[:sort_expired].present?
      @tasks = Task.closest_to_deadline
    elsif params[:task].nil?
      @tasks = Task.of_newest
    elsif params[:task][:search].present? && params[:task][:status].present? && params[:task][:priority].present?
      @tasks = Task.search_by_title_and_status_and_priority(
        params[:task][:title], params[:task][:status], params[:task][:priority]
        )
    elsif params[:task][:status].present?
      @tasks = Task.search_by_title_and_status(
        params[:task][:title], params[:task][:status]
        )
    elsif params[:task][:priority].present?
      @tasks = Task.search_by_title_and_priority(
        params[:task][:title], params[:task][:priority]
        )
    else
      @tasks = Task.search_by_title(params[:task][:title])
    end

    @tasks = @tasks.page(params[:page]).per(10)
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
