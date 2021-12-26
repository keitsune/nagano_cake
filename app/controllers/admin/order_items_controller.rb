class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)
    if @order_item.making_status == "in_production"
      @order.update(status: 2)
    elsif @order.order_items.where(making_status: 3).count == @order.order_items.count
      @order.update(status: 3)
    end
    redirect_to admin_order_path(@order)
  end 
  
  private
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :amount, :price, :making_status)
  end
end
