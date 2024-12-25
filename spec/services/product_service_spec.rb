require 'rails_helper'

RSpec.describe ProductService do
  let(:product) { instance_double("Product", id: 1, name: "Sample Product", stock_quantity: 10) }
  let(:product_params) { { name: "New Product", stock_quantity: 20 } }

  describe '#call' do
    context 'when action is :all' do
      it 'returns all products' do
        allow(Product).to receive(:all).and_return([product])

        service = ProductService.new(:all)
        result = service.call

        expect(result).to eq([product])
      end
    end

    context 'when action is :find' do
      it 'returns nil if product is not found' do
        allow(Product).to receive(:find_by).with(id: product.id).and_return(nil)

        service = ProductService.new(:find, product.id)
        result = service.call

        expect(result).to be_nil
      end
    end

    context 'when action is :check_inventory' do
      it 'returns the product if found' do
        allow(Product).to receive(:find_by).with(id: product.id).and_return(product)

        service = ProductService.new(:check_inventory, product.id)
        result = service.call

        expect(result).to eq(product)
      end

      it 'returns nil if product is not found' do
        allow(Product).to receive(:find_by).with(id: product.id).and_return(nil)

        service = ProductService.new(:check_inventory, product.id)
        result = service.call

        expect(result).to be_nil
      end
    end

    context 'when action is :update' do
      it 'updates the product successfully' do
        allow(Product).to receive(:find).with(product.id).and_return(product)
        allow(product).to receive(:update).with(product_params).and_return(true)

        service = ProductService.new(:update, product.id, product_params)
        result = service.call

        expect(result).to eq({ product: product })
      end

      it 'returns errors if product update fails' do
        allow(Product).to receive(:find).with(product.id).and_return(product)
        allow(product).to receive(:update).with(product_params).and_return(false)
        allow(product).to receive(:errors).and_return(double(full_messages: ["Stock quantity can't be blank"]))

        service = ProductService.new(:update, product.id, product_params)
        result = service.call

        expect(result).to eq({ errors: ["Stock quantity can't be blank"] })
      end
    end

    context 'when action is :destroy' do
      it 'destroys the product successfully' do
        allow(Product).to receive(:find).with(product.id).and_return(product)
        allow(product).to receive(:destroy).and_return(true)

        service = ProductService.new(:destroy, product.id)
        result = service.call

        expect(result).to eq({ message: 'Product deleted successfully' })
      end

      it 'returns errors if product deletion fails' do
        allow(Product).to receive(:find).with(product.id).and_return(product)
        allow(product).to receive(:destroy).and_return(false)

        service = ProductService.new(:destroy, product.id)
        result = service.call

        expect(result).to eq({ errors: ['Failed to delete product'] })
      end
    end

    context 'when action is invalid' do
      it 'raises an ArgumentError' do
        service = ProductService.new(:invalid_action)
        expect { service.call }.to raise_error(ArgumentError, "Invalid action: invalid_action")
      end
    end
  end
end
