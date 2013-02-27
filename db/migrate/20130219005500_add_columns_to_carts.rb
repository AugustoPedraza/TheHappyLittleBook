class AddColumnsToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :is_sale, :boolean, null: false, default: false
    add_column :carts, :sale_date, :datetime

    add_column :carts, :is_purchase, :boolean, null: false, default: false
    add_column :carts, :purchase_date, :datetime

  end
end
