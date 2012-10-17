class ProjectsController < ApplicationController
  respond_to :html, :json
  
  def new
    @project = Project.new
	respond_with(@project, :layout => !request.xhr?)
  end

  def edit
    @project = Project.find(params[:id])
	respond_with(@project, :layout => !request.xhr?)
  end

  def create
    @project = Project.new(params[:project].merge({:user => current_user}))    
    if @project.save
	  respond_with(@project, :partial => 'item', :object => @project)
	else
	  render :action => 'new'
	end
  end

  def update
	@project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
	  render :json => @project
	else
	  render :action => 'edit'
	end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render :json => @project and return
    end
    redirect_to projects_path
  end

  def show
    @project = Project.find(params[:id])
    @priorities = current_user.priorities
  end

  def index
    @projects = current_user.projects
  end

end
