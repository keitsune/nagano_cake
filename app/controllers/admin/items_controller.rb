class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_items_path
  end

  def index
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end
end
