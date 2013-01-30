class CreateAuthorsBooks < ActiveRecord::Migration
  def up
    create_table :authors_books, :id => false do |t|
     t.integer    :author_id
     t.integer    :book_id
   end
   add_index :authors_books, [:author_id, :book_id]
   add_foreign_key "authors_books", "authors", :name => "authors_books_author_id_fk", :primary_key => "author_id"
   add_foreign_key "authors_books", "books", :name => "authors_books_book_id_fk", :primary_key => "book_id"
  end

  def down
    drop_table :authors_books
  end
end
