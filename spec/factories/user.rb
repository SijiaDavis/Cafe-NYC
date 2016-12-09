FactoryGirl.define do
  factory :user do
    sequence :email do |n| 
      "person#{n}@example.com"
    end
    password "fake_password"
    password_confirmation "fake_password"
  end
end