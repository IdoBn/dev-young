# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    name "MyString"
    content "MyString"
    url "MyString"
    user_id 1
  end
end
