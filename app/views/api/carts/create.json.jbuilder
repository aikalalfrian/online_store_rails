json.cart do
  json.id @cart.id
  json.user_id @cart.user_id
  json.product_id @cart.product_id
  json.quantity @cart.quantity
end
