# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request do
    user_id 1
    group_id 1
    group_confirm false
    user_confirm false
  end
end
