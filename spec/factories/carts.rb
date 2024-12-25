FactoryBot.define do
  factory :cart do
    association :user
    product
    quantity { 1 }
  end
end
