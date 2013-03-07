class CreateBasicSalaries < ActiveRecord::Migration
  def change
    create_table :basic_salaries, primary_key: "basic_salary_id" do |t|
      t.datetime :effect_since, null: false
      t.datetime :effect_to
      t.float :amount,          null: false

      t.timestamps
    end

    add_column :pay_slips, :basic_salary_id, :integer
    add_index  :pay_slips, :basic_salary_id
    add_foreign_key "pay_slips", "basic_salaries", name: "pay_slip_basic_salary_fk", primary_key: "basic_salary_id"
  end
end
