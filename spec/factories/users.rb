FactoryGirl.define do
  factory :user do    
    sequence(:name){ |n| "User-#{n}" }
    sequence(:email){ |n| "email#{n}@askrubyist.com" }
    password "12345678"
  end 
end
