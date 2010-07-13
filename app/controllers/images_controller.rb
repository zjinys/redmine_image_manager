class ImagesController < ApplicationController
  unloadable

  before_filter :find_project
  
  def index
    
    
  end

  def new
  end

  def show
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
    render_404
  end
end
