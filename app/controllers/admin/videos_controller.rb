class Admin::VideosController < Admin::AdminController

  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def destroy
    Video.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_videos_path
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(params.require(:video).permit(:link,:sort))
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_video_path(@video)
  end

  def create
    @video = Video.new(params.require(:video).permit(:link,:sort))
    if @video.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_video_path(@video)
  end

end
