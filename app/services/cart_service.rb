class CartService
  def initialize(action, user = nil, product_id = nil, quantity = nil)
    @action = action
    @user = user
    @product_id = product_id
    @quantity = quantity
  end

  def call
    case @action
    when :create
      create_cart(@user, @product_id, @quantity)
    when :checkout
      checkout(@user)
    when :get_all
      get_all_carts(@user)
    else
      raise ArgumentError, "Invalid action: #{@action}"
    end
  end

  private

  def create_cart(user, product_id, quantity)
    product = Product.includes(:carts).find(product_id)

    if product.stock_quantity < quantity
      { error: 'Insufficient stock' }
    else
      cart = Cart.create(user_id: user.id, product_id: product.id, quantity: quantity)
      product.stock_quantity -= quantity
      product.save
      { cart: cart }
    end
  end

  def checkout(user)
    carts = Cart.where(user_id: user.id)

    if carts.empty?
      return { error: 'No items in cart to checkout' }
    end

    carts.each do |cart|
      product = Product.find(cart.product_id)

      if product.stock_quantity < cart.quantity
        return { error: 'Insufficient stock for the product' }
      end

      Checkout.create(user: user, product: product, quantity: cart.quantity, checked_out_at: Time.current)
    end

    Cart.where(user_id: user.id).destroy_all

    { message: 'Order processed successfully' }
  end

  def get_all_carts(user)
    carts = Cart.where(user_id: user.id)
    carts
  end
end
