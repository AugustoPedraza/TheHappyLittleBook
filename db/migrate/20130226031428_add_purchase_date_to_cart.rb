class AddPurchaseDateToCart < ActiveRecord::Migration
  def change
    add_column :carts, :purchase_date, :datetime
  end
end
