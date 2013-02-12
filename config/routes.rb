TheHappyLitteBook::Application.routes.draw do
  resources :cart_items


  resources :carts

  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config

  resources :books

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users
  resources :users
end
