class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    if @order.save
    current_customer.cart_items.each do |cart_item|
      @order_item = OrderItem.new(order_id: @order.id, item_id: cart_item.item_id, amount: cart_item.amount, price: cart_item.item.price * 1.1)
      @order_item.save
    end
      @cart_items = current_customer.cart_items
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      redirect_to cart_items_path
    end
  end

  def confirm
     @cart_items = current_customer.cart_items
     @order = current_customer.orders.new
     @sum = 0
     @cart_items.each do |cart_item|
      @sum += (cart_item.item.price * 1.1 * cart_item.amount).to_i
     end
     @order.shipping_cost = 800
     @order.total_payment = @order.shipping_cost + @sum
     @order.payment_method = params[:order][:payment_method]
     #byebug
     if params[:order][:address_option] == '0'
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name
     elsif params[:order][:address_option] == '1'
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
     elsif params[:order][:address_option] == '2'
       @order.postal_code = params[:order][:postal_code]
       @order.address = params[:order][:address]
       @order.name = params[:order][:name]
     end

  end

  def thanks
  end

  def index
    @orders = current_customer.orders
    
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
     @sum = 0
     @order.order_items.each do |order_item|
      @sum += (order_item.price) * (order_item.amount)
     end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :status)
  end
end
