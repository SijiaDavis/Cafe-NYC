FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "fake_password"
    password_confirmation "fake_password"
  end
end