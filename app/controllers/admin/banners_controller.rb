class Admin::BannersController < Admin::AdminController

  def index
    @banners = Banner.paginate(:page => params[:page], :per_page => 1)
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def update
    @banner = Banner.find(params[:id])
    if @banner.update(params.require(:banner).permit(:link,:pic,:sort))
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_banner_path(@banner)
  end

end
