TheHappyLitteBook::Application.routes.draw do
  resources :cart_items

  devise_scope :user do
    get "/register", :to => "devise/registrations#new", as: :new_registration
    post "/users(.:format)", :to => "devise/registrations#create", as: :create_registration

    post "/users/sign_in(.:format)", :to => "devise/sessions#create", as: :create_session

    get '/users/edit(.:format)', :to => "devise/registrations#edit", as: :edit_registered_user
  end

  resources :carts, :only => [:show, :update, :edit]

  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config

  resources :books, :only => [:index]

  authenticated :user do
    root :to => 'books#index'
  end

  root :to => "books#index"

  devise_for :users

  get "/purchases", :to => "carts#index", as: :sales

end
