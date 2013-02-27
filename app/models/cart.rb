class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  scope :sales_by_user,   lambda{ |user_id| where("user_id = ? AND is_sale = ?", user_id, true).order('updated_at DESC') }
  scope :sales,           where(is_sale: true).order("updated_at DESC")
  # scope :for_invoice,       lambda {|project, from, to| where(:project_id => project, :date => from..to) }

  #cuando guarde el modelo como una compra, tengo que actualizar el stock..

  def total
    cart_items.map(&:subtotal).sum
  end

  def items_count
    cart_items.map(&:quantity).sum
  end

  def make_sale
    self.is_sale    = true
    self.sale_date  = DateTime.now

    cart_items.map(&:update_available_stock)

    self.save
  end
end
