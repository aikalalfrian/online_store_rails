json.carts do
  json.array! @carts do |cart|
    json.id cart.id
    json.user_id cart.user_id
    json.product_id cart.product_id
    json.quantity cart.quantity
    json.created_at cart.created_at
    json.updated_at cart.updated_at
  end
end