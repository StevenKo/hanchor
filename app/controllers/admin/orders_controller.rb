class Admin::OrdersController < Admin::AdminController

  def index
    @orders = Order.showed.paginate(:page => params[:page], :per_page => 30).order("id DESC")
  end

  def export_orders
    @orders = Order.showed.all
    respond_to do |format|
      format.xls
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def change_status
    @order = Order.find(params[:id])
    @order.status = params[:value]
    @order.fill_fake_attribute
    if @order.save
      flash[:notice] = "successful change status"
    else
      flass[:error] = "error happen, try again"
    end
    redirect_to admin_order_path(@order)
  end

  def destroy
    order = Order.find(params[:id])
    order.update_attribute(:is_show, false)

    flash[:notice] = "delete success"
    redirect_to admin_orders_path
  end

end
