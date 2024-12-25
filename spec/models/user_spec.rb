require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'associations' do
    it { should have_many(:carts).dependent(:destroy) }
    it { should have_many(:products).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@kiwil.com')
      user.email = 'test@kiwil.com'
      expect(user).not_to be_valid
    end
  end

  describe 'devise modules' do
    it 'validates password presence' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'validates password confirmation' do
      user.password_confirmation = 'wrong_password'
      expect(user).not_to be_valid
    end
  end

  describe 'mocking and stubbing' do
    it 'stubs the email method' do
      allow(user).to receive(:email).and_return('stubbed_email@kiwil.com')
      expect(user.email).to eq('stubbed_email@kiwil.com')
    end

    it 'mocks the carts association' do
      allow(user).to receive(:carts).and_return(['cart1', 'cart2'])
      expect(user.carts).to eq(['cart1', 'cart2'])
    end
  end
end
