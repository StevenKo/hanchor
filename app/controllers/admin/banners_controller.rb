class Admin::BannersController < Admin::AdminController

  def index
    @banners = Banner.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def new
    @banner = Banner.new
  end

  def update
    @banner = Banner.find(params[:id])
    if @banner.update(banner_param)
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_banner_path(@banner)
  end

  def create
    @banner = Banner.new(banner_param)
    if @banner.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_banner_path(@banner)
  end

  def destroy
    Banner.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_banners_path
  end

private
  def banner_param
    params.require(:banner).permit(:pic,:link,:sort)
  end

end
