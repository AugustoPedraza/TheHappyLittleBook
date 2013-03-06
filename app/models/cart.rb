class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider
  has_many :cart_items, dependent: :destroy

  scope :sales_by_user,   lambda{ |user_id| where("user_id = ? AND is_sale = ?", user_id, true).order('updated_at DESC') }

  scope :purchases_by_provider,
    lambda{ |provider_id| where("provider_id = ? AND is_purchase = ?", provider_id, true).order('updated_at DESC') }


  scope :sales,           where(is_sale: true).order("updated_at DESC")
  scope :purchases,       where(is_purchase: true).order("updated_at DESC")

  # scope :for_invoice,       lambda {|project, from, to| where(:project_id => project, :date => from..to) }

  #cuando guarde el modelo como una compra, tengo que actualizar el stock..

  validates :provider, :purchase_date,  presence: true, if: :is_purchase
  validates :user,                      presence: true, if: :is_sale
  validate :validate_items,                             if: :is_purchase

  attr_accessible :cart_id, :user, :provider, :cart_items_attributes, :purchase_date, :provider_id, :is_purchase
  accepts_nested_attributes_for :cart_items, allow_destroy: true

  def total
    cart_items.map(&:subtotal).sum
  end

  def items_count
    cart_items.map(&:quantity).sum || 0
  end

  def validate_items
    unless items_count > 0
      errors.add(:purchase_date, "No se puede crear una compra sin items!")
    end
  end

  def make_sale
    self.is_sale    = true
    self.sale_date  = DateTime.now

    cart_items.each(&:update_available_stock)

    self.save
  end

  def make_purchase
    self.is_purchase    = true
    self.purchase_date  = DateTime.now

    cart_items.each(&:update_stock_and_price)

    save!
  end
end
