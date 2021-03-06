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
    current_user.done_notify if current_user.tasks.where.not(done: true).count == 0
    respond_to do |format|
      format.html { redirect_to(tasks_path) }
      format.json { render json: @task }
    end
  end

  def sort
    task = Task.find(params[:task_id])
    result = task.update(task_params)
    if result
      render json: {success: result}
    else
      render json: {success: result}, status: 500
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to(tasks_path) }
      format.json { render json: @task }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :row_order, :user_id, :done, :row_order_position)
    end
end
