FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    stock_quantity { 10 }
    association :user
  end
end
