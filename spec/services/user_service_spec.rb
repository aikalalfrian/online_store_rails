require 'rails_helper'

RSpec.describe UserService do
  let(:user_params) { { email: "test@kiwil.com", password: "password", password_confirmation: "password" } }
  let(:user) { instance_double("User", email: "test@kiwil.com", valid_password?: true, save: true, auth_token: "valid_token") }

  describe '#call' do
    context 'when action is :create' do
      it 'creates a user successfully' do
        allow(User).to receive(:new).with(user_params).and_return(user)
        allow(user).to receive(:save).and_return(true)

        service = UserService.new(:create, user_params)
        result = service.call

        expect(result).to eq({ message: 'User created successfully' })
      end

      it 'returns errors when user creation fails' do
        allow(User).to receive(:new).with(user_params).and_return(user)
        allow(user).to receive(:save).and_return(false)
        allow(user).to receive(:errors).and_return(double(full_messages: ["Email can't be blank"]))

        service = UserService.new(:create, user_params)
        result = service.call

        expect(result).to eq({ errors: ["Email can't be blank"] })
      end
    end

    context 'when action is :login' do
      it 'logs in successfully with valid credentials' do
        allow(User).to receive(:find_for_database_authentication).with(email: user_params[:email]).and_return(user)
        allow(user).to receive(:valid_password?).with(user_params[:password]).and_return(true)
        allow(user).to receive(:update!).with(auth_token: anything)

        service = UserService.new(:login, nil, user_params[:email], user_params[:password])
        result = service.call

        expect(result).to have_key(:message)
        expect(result).to have_key(:user)
        expect(result).to have_key(:auth_token)
      end

      it 'returns an error when login fails' do
        allow(User).to receive(:find_for_database_authentication).with(email: user_params[:email]).and_return(nil)

        service = UserService.new(:login, nil, user_params[:email], user_params[:password])
        result = service.call

        expect(result).to eq({ error: 'Invalid email or password' })
      end
    end

    context 'when action is :checkout_history' do
      it 'returns checkout history for the user' do
        allow(user).to receive(:id).and_return(1)
        allow(Checkout).to receive(:where).with(user_id: user.id).and_return([])

        service = UserService.new(:checkout_history)
        service.set_user(user)
        result = service.call

        expect(result).to eq([])
      end

      it 'returns an error if user is not found' do
        service = UserService.new(:checkout_history)
        service.set_user(nil)
        result = service.call

        expect(result).to eq({ error: 'User not found' })
      end
    end
  end
end
