FactoryGirl.define do
  factory :place do
    name 'Cafe Lingo'
    description "Where the cool kids are."
    address "68 Jay Street, Suite 720, Brooklyn 11201"
    association :user_id
  end
end