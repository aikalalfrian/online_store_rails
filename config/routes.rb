Rails.application.routes.draw do
  namespace :api do
    resources :products, only: [:index, :show, :create, :update, :destroy] do
      member do
        get 'check_inventory'
      end
    end

    resources :carts, only: [:create, :index] do
      member do
        post :checkout
      end
    end

    resources :users, only: [:show, :update] do
      member do
        get 'checkout_history', to: 'users#checkout_history'
      end
    end

    post 'register', to: 'users#register'
    post 'login', to: 'users#login'
  end
end
