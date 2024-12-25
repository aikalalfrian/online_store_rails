json.array! @products do |product|
  json.id product.id
  json.name product.name
  json.stock_quantity product.stock_quantity
  json.carts product.carts do |cart|
    json.id cart.id
    json.user_id cart.user_id
    json.quantity cart.quantity
  end
end
