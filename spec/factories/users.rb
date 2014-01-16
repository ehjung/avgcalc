# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	email "test@example.com"
  	password "password"
  end

  factory :user2 do
  	email "test2@example.com"
  	password "password"
  end
end
