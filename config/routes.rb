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

  resources :welcome
  resources :dashboard
  resources :farms, only: [:edit, :update] do
    member do
      patch :title
      patch :description
      patch :contact_info
      patch :details
    end
  end
  resources :farm_sections, only: [:edit, :update]
  resources :farm_rates, only: [:edit, :update]
  resources :farm_categories, only: [:edit, :update]
  resources :farm_media_links, only: [:edit, :update]
  resources :farm_banner, only: [:edit, :update, :destroy]
  resources :farm_location, only: [:edit, :update]
  resources :bookings, only: [:index, :destroy] do
    collection do
      delete :destroy_all
    end
  end

  namespace :admin do
    resources :dashboard, only: :index
    resources :bookings, only: :index
    resources :users do
      collection do
        get :recently_joined
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :bookings, only: [:index, :destroy] do
        collection do
          delete :destroy_all
        end
      end
      resource :farms, only: [:edit, :update, :show]
      resource :farm_rates, only: [:edit, :update, :show]
      resource :farm_category, only: [:edit, :update, :show] do
        member do
          get :categories
        end
      end
    end
  end
end
