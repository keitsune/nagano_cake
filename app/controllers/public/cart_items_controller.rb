class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  before_action :correct_customer_destroy_all, only: :destroy_all

  def index
    @cart_items = current_customer.cart_items
  end

  def create

    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items.destroy_all
    flash[:danger] = "全て削除しました!"
    redirect_to cart_items_path
  end

  private

  def correct_customer_destroy_all
    @cart_items = current_customer.cart_items
    redirect_to root_path if @cart_items.nil?
  end


  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
