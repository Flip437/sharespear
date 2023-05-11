Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'comments/New'
  get 'comments/Create'
  get 'mailback/new'
  devise_for :users, path: 'users', controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'home#index'
  resources :searchbar, only: :index
  resources :landing_page, only: :index
  resources :search_friend, only: :index
  resources :home, only: [:index, :new, :create]
  resources :users do
    resources :dashboard, only: [:index, :update]
    resources :avatars, only: [:create]
    resources :follow, only: [:create,:destroy, :show]
    resources :usercomments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book_copies do
    collection do
      get :search_book_or_author
    end
    resources :borrows
    resources :posts do
      resources :comments
    end
  end

  resources :mailback, only: :new
end
