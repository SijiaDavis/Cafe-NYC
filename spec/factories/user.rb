FactoryGirl.define do
  factory :user do
    email 'fake_email@gmail.com'
    password "fake_password"
    password_confirmation "fake_password"
  end
end