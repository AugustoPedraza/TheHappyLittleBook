class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book_inventory

  scope :find_by_book_inventory, lambda { |inventory_id| where(book_inventory_id: inventory_id) }

  validates :cart, :book_inventory, presence: true

  attr_accessible :quantity

  def subtotal
    book_inventory.sale_price * quantity
  end
end
