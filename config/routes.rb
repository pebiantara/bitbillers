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
    root "dashboard#index"
  end
end