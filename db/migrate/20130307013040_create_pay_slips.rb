class CreatePaySlips < ActiveRecord::Migration
  def change
    create_table :pay_slips, primary_key: "pay_slip_id" do |t|
      t.datetime :date,   null: false
      t.integer :period,  null: false
      t.integer :employee_id

      t.timestamps
    end

    add_column :pay_slip_items, :pay_slip_id, :integer
    add_index  :pay_slip_items, :pay_slip_id
    add_foreign_key "pay_slip_items", "pay_slips", name: "pay_slip_item_pay_slip_fk", primary_key: "pay_slip_id"

    add_index  :pay_slips, :employee_id
    add_foreign_key "pay_slips", "employees", name: "pay_slip_employee_fk", primary_key: "employee_id"
  end
end
