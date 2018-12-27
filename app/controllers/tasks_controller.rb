class TasksController < ApplicationController
  before_action :login_request
  before_action :set_task, only: [:edit, :show, :update, :destroy]

  def index
    @tasks = if params[:task].present? && params[:task][:search].present?
               Task.search(
                 params[:task][:title],
                 params[:task][:status],
                 params[:task][:priority]
               )
             elsif params[:sort].present?
               Task.sort(params[:sort])
             elsif params[:label_search].present?
               Task.label_search(params[:label_search])
             else
               Task.order(created_at: :desc)
             end
    @tasks = @tasks.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.valid?
      ActiveRecord::Base.transaction do
        @task.save!
        if labeling_params[:label_ids] != nil
          labeling_params[:label_ids].each do |p|
            Labeling.create!(label_id: p.to_i, task_id: @task.id)
          end
        end
      end
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

  def task_params
    params.require(:task).permit(:title,
                                 :status,
                                 :priority,
                                 :deadline,
                                 :contents
                                 )
  end

  def labeling_params
    params.require(:task).permit(label_ids: [])
  end
end
