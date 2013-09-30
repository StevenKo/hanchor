class Admin::ShippingCostsController < Admin::AdminController

  def new
    @shipping_cost = ShippingCost.new
    @country_select = Country.generate_country_array
  end

  def index
    @shipping_costs = ShippingCost.all
  end

  def edit
    @shipping_cost = ShippingCost.find(params[:id])
    @country_select = Country.generate_country_array
  end

  def update
    @shipping_cost = ShippingCost.find(params[:id])
    if @shipping_cost.update(ship_params)
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_shipping_cost_path(@shipping_cost)
  end

  def create
    @shipping_cost = ShippingCost.new(ship_params)
    if @shipping_cost.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to admin_shipping_costs_path
  end

  def destroy
    ShippingCost.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_shipping_costs_path
  end

private

  def ship_params
    params.require(:shipping_cost).permit(:cost,:description,:country_id)
  end

end
