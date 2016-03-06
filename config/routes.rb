Rails.application.routes.draw do
  devise_scope :user do
    get "login" => "users/sessions#new", :as => :signin_user
    post "login" => "users/sessions#create", :as => :signin_user_create
    get "logout" => "users/sessions#destroy", :as => :signout_user
  end

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" }
  resources :users

  root "home#index"

  namespace :admin do
    root "trades#new"
    get 'settings' => 'configurations#edit', as: :settings
    patch 'update_setting' => 'configurations#update', as: :update_setting

    resources :trades do
      member do
        get :release
        patch :released
        get :status
        patch :change_status
      end
    end
    resources :dashboards, only: [:index]
    resources :users do
      member do
        get :status
        patch :change_status
        get :trades
        get :login_histories
      end
    end
    resources :stores
  end

  namespace :device do
    root "home#index"
    get "buy" => "home#buy", as: :buy
    get "bitbil" => "home#bitbil", as: :bitbil
    get "store" => "home#store", as: :store
    get "charge" => "home#charge", as: :charge
    get "verify" => "home#verify", as: :verify
  end
end