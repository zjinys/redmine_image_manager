class ImagesController < ApplicationController
  unloadable

  before_filter :find_project,:authorize, :except => :svninfo
  
  helper :attachments
  include AttachmentsHelper
  
  def index
    @images = Image.find(:all,:conditions=>['status=1 and project_id=?',@project.id])
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

  def svninfo
    image = Image.find_by_id(params[:id])
    svn_info = image.svn_repo + ":" + image.svn_path
    render :text=>svn_info
  end
  
  def show
    @image = Image.find_by_id(params[:id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
    render_404
  end
end
