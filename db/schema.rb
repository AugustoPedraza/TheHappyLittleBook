# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130219005500) do

  create_table "active_admin_comments", :primary_key => "admin_note_id", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authors", :primary_key => "author_id", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authors", ["last_name", "first_name"], :name => "index_authors_on_last_name_and_first_name", :unique => true

  create_table "authors_books", :id => false, :force => true do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "authors_books", ["author_id", "book_id"], :name => "index_authors_books_on_author_id_and_book_id"

  create_table "book_inventories", :primary_key => "book_inventory_id", :force => true do |t|
    t.decimal  "sale_price",      :precision => 8, :scale => 2,                :null => false
    t.integer  "quantity",                                      :default => 0, :null => false
    t.decimal  "purchase_price",  :precision => 8, :scale => 2,                :null => false
    t.integer  "solds_units",                                   :default => 0, :null => false
    t.integer  "purchased_units",                                              :null => false
    t.integer  "book_id"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "book_inventories", ["book_inventory_id"], :name => "index_book_inventories_on_book_inventory_id"

  create_table "books", :primary_key => "book_id", :force => true do |t|
    t.string   "title",        :null => false
    t.text     "description",  :null => false
    t.text     "isbn13",       :null => false
    t.date     "published_at", :null => false
    t.integer  "edition",      :null => false
    t.integer  "publisher_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "books", ["isbn13"], :name => "index_books_on_isbn13", :unique => true
  add_index "books", ["title", "edition"], :name => "index_books_on_title_and_edition", :unique => true

  create_table "cart_items", :primary_key => "cart_item_id", :force => true do |t|
    t.integer  "cart_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "quantity",                                 :default => 1,   :null => false
    t.integer  "book_id",                                                   :null => false
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  add_index "cart_items", ["cart_item_id"], :name => "index_cart_items_on_cart_item_id"

  create_table "carts", :primary_key => "cart_id", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_purchase", :default => false, :null => false
  end

  add_index "carts", ["cart_id"], :name => "index_carts_on_cart_id"

  create_table "publishers", :primary_key => "publisher_id", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "publishers", ["publisher_id"], :name => "index_publishers_on_publisher_id"

  create_table "roles", :primary_key => "role_id", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "cart_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  add_foreign_key "authors_books", "authors", :name => "authors_books_author_id_fk", :primary_key => "author_id"
  add_foreign_key "authors_books", "books", :name => "authors_books_book_id_fk", :primary_key => "book_id"

  add_foreign_key "book_inventories", "books", :name => "book_inventories_books_id_fk", :primary_key => "book_id"

  add_foreign_key "books", "publishers", :name => "books_publishers_id_fk", :primary_key => "publisher_id"

  add_foreign_key "cart_items", "books", :name => "cart_items_books_id_fk", :primary_key => "book_id"
  add_foreign_key "cart_items", "carts", :name => "cart_items_carts_id_fk", :primary_key => "cart_id"

  add_foreign_key "carts", "users", :name => "carts_users_id_fk", :primary_key => "user_id"

  add_foreign_key "users", "carts", :name => "users_carts_id_fk", :primary_key => "cart_id"

  add_foreign_key "users_roles", "roles", :name => "users_roles_role_id_fk", :primary_key => "role_id"
  add_foreign_key "users_roles", "users", :name => "users_roles_user_id_fk", :primary_key => "user_id"

end
