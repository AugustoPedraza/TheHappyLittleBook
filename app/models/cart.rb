class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  #cuando guarde el modelo como una compra, tengo que actualizar el stock..

  def total
    cart_items.map(&:subtotal).sum
  end

  def items_count
    cart_items.map(&:quantity).sum
  end

  def make_purchase
    update_attribute(:is_purchase, true)
  end
end
