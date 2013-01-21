# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    description "MyText"
    isbn13 ""
    publication_date "2013-01-19"
    edition ""
  end
end
