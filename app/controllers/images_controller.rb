class ImagesController < ApplicationController
  unloadable


  def index
    @project = Project.find(params[:project_id])
    
  end

  def new
  end

  def show
  end
end
