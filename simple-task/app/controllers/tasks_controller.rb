require 'CSV'

class TasksController < ApplicationController
  before_action :set_task, except: [:index, :new, :create, :download, :chart]
  before_action :pull_all_tasks, only: [:download, :chart]

  def index
    @completed_hours = current_user.tasks.completed_hours
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

  def download    
      send_data @tasks.to_csv, filename: "tasks-#{Date.today}.csv"
  end  

  def chart; end  

private

  def tasks_params
    params.require(:task).permit(:title, :body, :client, :duration, :status)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def pull_all_tasks
    @tasks = current_user.tasks.all
  end  

end
