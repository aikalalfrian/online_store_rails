require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:user) { create(:user, email: "default_admin@kiwil.com") }
  let(:product) { build(:product, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:carts).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      create(:product, name: 'Unique Product', user: user)
      product.name = 'Unique Product'
      expect(product).not_to be_valid
    end

    it 'is not valid without a stock_quantity' do
      product.stock_quantity = nil
      expect(product).not_to be_valid
    end

    it 'is not valid with a negative stock_quantity' do
      product.stock_quantity = -1
      expect(product).not_to be_valid
    end

    it 'is not valid with a non-integer stock_quantity' do
      product.stock_quantity = 2.5
      expect(product).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'ensures stock_quantity is non-negative before saving' do
      product.stock_quantity = -5
      expect { product.save }.to change { product.errors.count }.by(1)
      expect(product.errors[:stock_quantity]).to include("must be greater than or equal to 0")
    end

    it 'sets the user before validation' do
      product.save
      expect(product.user).to eq(user)
    end
  end
end
