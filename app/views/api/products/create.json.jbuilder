json.message 'Product created successfully'
json.product do
  json.id @product.id
  json.name @product.name
  json.stock_quantity @product.stock_quantity
end
