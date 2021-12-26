class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    #@order_items.shipping_cost = 800
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order.order_items.each do |order_item|
        order_item.update(making_status: 1)
      end
    end
    redirect_to admin_order_path
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :status)
  end 
end


