class TasksController < ApplicationController

  before_filter :project

  def new
  end

  def edit
	@task = Task.find(params[:id])
  end

  def create
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => 'Task was saved successfully'
    else
      render :action => 'new'
    end
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => 'Task was updated successfully'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_path(@project)
  end

  private 

  def project
	@project = Project.find(params[:project_id])
  end

end
