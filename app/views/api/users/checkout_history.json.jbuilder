json.checkouts do
  json.array! @checkouts do |checkout|
    json.id checkout.id
    json.user_id checkout.user_id
    json.product_id checkout.product_id
    json.quantity checkout.quantity
    json.checked_out_at checkout.checked_out_at
    json.created_at checkout.created_at
    json.updated_at checkout.updated_at
  end
end
