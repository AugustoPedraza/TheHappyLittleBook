# encoding: UTF-8

class Book < ActiveRecord::Base
  DEFAULT_GANANCIA = 0.8

  default_scope order('published_at')

  scope :with_stock, joins(:book_inventories).where("book_inventories.quantity > 0").order("created_at ASC").uniq

  has_and_belongs_to_many :authors
  belongs_to :publisher
  has_many   :book_inventories

  attr_accessible :description, :edition, :isbn13, :published_at, :title, :publisher

  validates :description,      presence: true
  validates :edition,          presence: true
  validates :isbn13,           presence: true, :uniqueness => true
  validates :published_at,     presence: true
  validates :title,            presence: true,
    uniqueness: { scope: :edition,
      message: "No puede haber un libro con el mismo título e número de edición."}

  def summary
    description[0..140] + "..."
  end

  def full_name
    title + " (#{edition}° edición)"
  end

  def current_price
    book_inventories.last.sale_price
  end

  def available_stock
    book_inventories.last.quantity
  end

  def update_inventory(units, price=nil)
    if last_inventory = book_inventories.last
      last_inventory.update_inventory(units, price)
    else
      BookInventory.create_or_update_purchase(nil, units, price, self)
    end
  end
end

#Aqui voy a definir una constante que diga cual es el porcentaje de ganancias por defecto