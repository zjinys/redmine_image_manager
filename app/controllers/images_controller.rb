class ImagesController < ApplicationController
  unloadable

  before_filter :find_project
  
  def index
    
    
  end

  def new
    @image = Image.new(:project => @project, :author => User.current)
    if request.post?
      @image.attributes = params[:image]
      if @image.save
        attachments = Attachment.attach_files(@image, params[:attachments])
        render_attachment_warning_if_needed(@image)

        flash[:notice] = l(:notice_successful_create)
        redirect_to :action => "index", :project_id => params[:project_id]
      else
        render :action => "new", :id => params[:id]
      end
    end
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
