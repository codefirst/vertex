class TasksController < ApplicationController
  respond_to :html, :json

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.rank(:row_order)
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_to do |format|
      format.html { redirect_to(tasks_path) }
      format.json { respond_with_bip(@task) }
    end
  end

  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render nothing: true
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :row_order, :user_id, :done, :row_order_position)
    end
end
