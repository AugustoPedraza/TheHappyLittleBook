# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart_item do
    book_id 1
    book_inventory_id 1
    cart_id 1
  end
end
