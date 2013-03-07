class CreatePaySlipItems < ActiveRecord::Migration
  def change
    create_table :pay_slip_items, primary_key: "pay_slip_item_id" do |t|
      t.integer :amount,        null: false, default: 1

      t.timestamps
    end
  end
end
