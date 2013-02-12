class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total
    cart_items.map(&:subtotal).sum
  end

  def items_count
    cart_items.map(&:quantity).sum
  end
end
