class Api::ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = ProductService.new(:all, current_user).call
    render 'api/products/index'
  end

  def show
    @product = ProductService.new(:find, params[:id]).call

    if @product.present?
      render 'api/products/show'
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def check_inventory
    @product = ProductService.new(:check_inventory, params[:id]).call

    if @product.present?
      render 'api/products/check_inventory'
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def create
    product_params = params.require(:product).permit(:name, :stock_quantity)
    result = ProductService.new(:create, nil, product_params).call

    if result[:errors]
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    else
      render json: result[:product], status: :created
    end
  end

  def update
    product_params = params.require(:product).permit(:name, :stock_quantity)
    result = ProductService.new(:update, params[:id], product_params).call

    if result[:errors]
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    else
      @product = result[:product]
      render 'api/products/update', status: :ok
    end
  end

  def destroy
    result = ProductService.new(:destroy, params[:id]).call

    if result[:errors]
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    else
      render 'api/products/destroy', status: :ok
    end
  end
end
