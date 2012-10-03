class PrioritiesController < ApplicationController

  def create
    @priority = Priority.new(params[:priority].merge({:user => current_user}))
    if @priority.save
      redirect_to projects_path, :notice => 'Priority was updated successfully'
    end
  end

  def update
    @priority = Priority.find(params[:id])
    if @priority.update_attributes(params[:priority])
      redirect_to projects_path, :notice => 'Priority was updated successfully'
    end
  end

  def destroy
    priority = Priority.find(params[:id])
    priority.destroy
    redirect_to project_path(projects_path)
  end
end
