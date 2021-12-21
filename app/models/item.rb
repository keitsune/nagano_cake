class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  attachment :image
  
  validates :name, presence: true
  validates :image_id, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

end
