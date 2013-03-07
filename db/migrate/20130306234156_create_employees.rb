class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees, primary_key: "employee_id" do |t|
      t.string   :first_name,   null: false
      t.string   :last_name,    null: false
      t.string   :cuil,         null: false
      t.datetime :birth_date,   null: false
      t.datetime :join_date,    null: false
      t.boolean     :married,      null: false, default: false
      t.datetime :unjoin_date

      t.timestamps
    end
  end
end
