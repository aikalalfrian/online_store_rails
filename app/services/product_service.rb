class ProductService
  def initialize(action, product_id = nil, product_params = nil)
    @action = action
    @product_id = product_id
    @product_params = product_params
  end

  def call
    case @action
    when :all
      Product.all
    when :find
      find_product(@product_id)
    when :check_inventory
      check_inventory(@product_id)
    when :create
      create_product(@product_params)
    when :update
      update_product(@product_id, @product_params)
    when :destroy
      destroy_product(@product_id)
    else
      raise ArgumentError, "Invalid action: #{@action}"
    end
  end

  private

  def all_products
    Product.includes(:carts).all
  end

  def find_product(product_id)
    Product.includes(:carts).find_by(id: product_id)
  end

  def check_inventory(product_id)
    Product.find_by(id: product_id)
  end

  def create_product(product_params)
    product = Product.new(product_params)
    if product.save
      { product: product }
    else
      { errors: product.errors.full_messages }
    end
  end

  def update_product(product_id, product_params)
    product = Product.find(product_id)
    if product.update(product_params)
      { product: product }
    else
      { errors: product.errors.full_messages }
    end
  end

  def destroy_product(product_id)
    product = Product.find(product_id)
    if product.destroy
      { message: 'Product deleted successfully' }
    else
      { errors: ['Failed to delete product'] }
    end
  end
end
