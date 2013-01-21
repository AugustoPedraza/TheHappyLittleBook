class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books, primary_key: "id" do |t|
      t.string  :title,            null: false
      t.text    :description,      null: false
      t.text    :isbn13,           null: false, uniqueness: true
      t.date    :published_at,     null: false
      t.integer :edition,          null: false

      t.timestamps
    end

    add_index :books, [:title, :edition], unique: true
    add_index :books, :isbn13,            unique: true
  end
end
