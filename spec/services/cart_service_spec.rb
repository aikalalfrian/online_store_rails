require 'rails_helper'

RSpec.describe CartService do
  let(:user) { instance_double("User", id: 1) }
  let(:product) { instance_double("Product", id: 1, stock_quantity: 10) }
  let(:cart) { instance_double("Cart", id: 1, user_id: user.id, product_id: product.id, quantity: 2) }

  describe '#call' do
    context 'when action is :checkout' do
      it 'returns an error if there are no items in the cart' do
        allow(Cart).to receive(:where).with(user_id: user.id).and_return([])

        service = CartService.new(:checkout, user)
        result = service.call

        expect(result).to eq({ error: 'No items in cart to checkout' })
      end

      it 'returns an error if there is insufficient stock during checkout' do
        allow(Cart).to receive(:where).with(user_id: user.id).and_return([cart])
        allow(Product).to receive(:find).with(cart.product_id).and_return(product)
        allow(product).to receive(:stock_quantity).and_return(1)

        service = CartService.new(:checkout, user)
        result = service.call

        expect(result).to eq({ error: 'Insufficient stock for the product' })
      end
    end

    context 'when action is :get_all' do
      it 'returns all carts for the user' do
        allow(Cart).to receive(:where).with(user_id: user.id).and_return([cart])

        service = CartService.new(:get_all, user)
        result = service.call

        expect(result).to eq([cart])
      end
    end

    context 'when action is invalid' do
      it 'raises an ArgumentError' do
        service = CartService.new(:invalid_action)
        expect { service.call }.to raise_error(ArgumentError, "Invalid action: invalid_action")
      end
    end
  end
end
