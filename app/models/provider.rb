class Provider < ActiveRecord::Base
  attr_accessible :address, :cuit, :name

  has_many :carts, conditions: {:is_purchase => true}, order: "purchase_date DESC"

  validates :address,      presence: true
  validates :cuit,         presence: true, :uniqueness => true
  validates :name,         presence: true

  validates :cuit, :format => { :with => /\s*\d{2}-\d{8}-\d{1}\s*/,
    :message => "El formato del cuit debe ser: xx-xxxxxxxx-xx" }

  #El proveedor, puede subministrar varias editoriales.
end
