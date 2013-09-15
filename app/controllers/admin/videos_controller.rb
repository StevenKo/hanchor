class Admin::VideosController < Admin::AdminController

  def index
    @videos = Video.paginate(:page => params[:page], :per_page => 1)
  end

  def edit
    @video = Video.find(params[:id])
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

end
