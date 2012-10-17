class TasksController < ApplicationController
  respond_to :html, :json

  before_filter :set_project

  def new
	@task = @project.tasks.new
  end

  def edit
	@task = Task.find(params[:id])
	respond_with(@task, :layout => !request.xhr?)
  end

  def create
	@task = @project.tasks.build(params[:task])
	if @task.save
	  respond_with(@task, :partial => 'item', :object => @task)
    else
      render :action => 'new'
    end
  end

  def update
	@task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
	  render :json => @task, :root => false
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render :json => @task and return
    end
    redirect_to project_path(@project)
  end

  private 

  def set_project
	@project = Project.find(params[:project_id])
  end

end
