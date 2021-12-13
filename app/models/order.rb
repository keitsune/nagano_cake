class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: {
    waiting_for_deposit: 0,
    payment_confirmation: 1,
    under_production: 2,
    preparing_to_ship: 3,
    sent: 4
  }
end
