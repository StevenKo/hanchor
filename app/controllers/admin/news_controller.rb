class Admin::NewsController < Admin::AdminController

  def index
    @news = News.paginate(:page => params[:page], :per_page => 1)
  end

  def show
    @news = News.find(params[:id])
  end

end
