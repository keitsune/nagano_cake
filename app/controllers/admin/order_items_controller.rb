class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update
    redirect_to admin_customer_path
  end 
  
  private
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :amount, :price, :making_status)
  end
end
