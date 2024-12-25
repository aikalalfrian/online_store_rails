require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:user) { create(:user, email: "default_admin_2@kiwil.com") }
  let!(:product) { create(:product, stock_quantity: 10) }
  let(:cart) { build(:cart, user: user, product: product) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(cart).to be_valid
    end

    it 'is not valid without a user_id' do
      cart.user_id = nil
      expect(cart).not_to be_valid
    end

    it 'is not valid without a product_id' do
      cart.product_id = nil
      expect(cart).not_to be_valid
    end

    it 'is not valid without a quantity' do
      cart.quantity = nil
      expect(cart).not_to be_valid
    end

    it 'is not valid with a non-integer quantity' do
      cart.quantity = 2.5
      expect(cart).not_to be_valid
    end

    it 'is not valid with a quantity less than or equal to zero' do
      cart.quantity = 0
      expect(cart).not_to be_valid
    end

    it 'is not valid if the product does not exist' do
      cart.product_id = 9999
      expect(cart).not_to be_valid
      expect(cart.errors[:product_id]).to include("must be a valid product")
    end

    it 'is not valid if the quantity exceeds available stock' do
      cart.quantity = 15
      expect(cart).not_to be_valid
      expect(cart.errors[:quantity]).to include("exceeds available stock")
    end
  end

  describe 'callbacks' do
    it 'sets the user before validation' do
      cart.save
      expect(cart.user).to eq(user)
    end
  end
end
