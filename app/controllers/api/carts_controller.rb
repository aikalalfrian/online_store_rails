class Api::CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    result = CartService.new(:get_all, current_user).call
    render json: result, status: :ok
  end

  def create
    result = CartService.new(:create, current_user, params[:product_id], params[:quantity]).call

    if result[:error]
      render json: { error: result[:error] }, status: :unprocessable_entity
    else
      @cart = result[:cart]
      render json: @cart, status: :created
    end
  end

  def checkout
    result = CartService.new(:checkout, current_user).call

    if result[:error]
      render json: { error: result[:error] }, status: :unprocessable_entity
    else
      render json: { message: result[:message] }, status: :ok
    end
  end
end
