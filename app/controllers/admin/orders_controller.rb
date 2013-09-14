class Admin::OrdersController < Admin::AdminController

  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 1)
  end

  def show
    @order = Order.find(params[:id])
  end

  def change_status
    @order = Order.find(params[:id])
    @order.status = params[:value]
    if @order.save
      flash[:notice] = "successful change status"
    else
      flass[:error] = "error happen, try again"
    end
    redirect_to admin_order_path(@order)
  end

end
