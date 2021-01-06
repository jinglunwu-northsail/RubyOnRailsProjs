class TasksController < ApplicationController
  before_action :set_task, except: [:index, :new, :create]

  def index
    @tasks = current_user.tasks.by_state
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(tasks_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created"
    else
      render('new')
    end
  end

  def edit; end

  def update
    if @task.update(tasks_params)
      redirect_to tasks_path, notice: "Task updated"
    else
      render('edit')
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted"
  end

private

  def tasks_params
    params.require(:task).permit(:title, :body, :client, :duration, :status)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
