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
	  render :json => gen_response, :root => false
	end
  end

  def update
	@project = Project.find(params[:id])
    @project.update_attributes(params[:project])
	render :json => gen_response, :root => false
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render :json => gen_response, :root => false and return
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

  private
  
  def gen_response
	{:data => @project, :errors => @project.errors.full_messages}
  end

end
