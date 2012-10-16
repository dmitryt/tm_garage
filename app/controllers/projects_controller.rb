require 'json'

class ProjectsController < ApplicationController
  def new
    @project = Project.new
    respond_to do |format|
      format.html {render :partial => 'form'}
      format.json 
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    # @project = Project.new(params[:project].merge({:user => current_user}))
    p params[:project]
    @project = Project.find(2)
    
    #if @project.save
      respond_to do |format|
        format.html
        format.json do
        {:data => @project.to_json, :template => render_to_string('_item.html', :layout => false, :locals => {:item => @project})}.to_json
        end
      end
    #else
    #  render :action => 'new'
    #end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice => 'Project was updated successfully'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
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
