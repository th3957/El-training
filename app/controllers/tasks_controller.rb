class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show, :update, :destroy]

  def index
    if params[:sort_expired].present?
      @tasks = Task.all.order("deadline")
    else
      @tasks = Task.all.order("created_at")
    end
  end

  def create
    @task = Task.create(task_params)
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title,
                                 :priority,
                                 :state,
                                 :deadline,
                                 :contents,
    )
  end
end
