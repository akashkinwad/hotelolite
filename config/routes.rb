Rails.application.routes.draw do

  root to: 'welcome#index'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get 'confirm_email', action: 'confirm_email', controller: 'users/registrations', as: 'confirm_registration'
  end

  resources :welcome
  resources :dashboard
  resources :api_tokens
  resources :farms

  resources :users do
    resources :payment_details
    resources :orders
  end

  resources :plans, only: :index do
    collection do
      get :available_monthly_yearly
    end
    resources :subscriptions, only: [:index, :new, :create, :edit, :update], module: 'plans' do
      collection do
        get 'monthly_success'
        get 'yearly_success'
      end
    end
  end

  namespace :admin do
    resources :dashboard
    resources :plans
    resources :tournaments
    resources :admins
    resources :subscriptions
    resources :settings
    resources :orders
    resources :users do
      collection do
        get :recently_joined
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :matches, only: [:index, :show]
      resources :tournaments, only: [:index, :show]
      resources :users do
        collection do
          post 'login'
        end
      end
    end
  end
end
