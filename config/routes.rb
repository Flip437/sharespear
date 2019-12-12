Rails.application.routes.draw do

  get 'mailback/new'
  devise_for :users, path: 'users', controllers: { registrations: 'users/registrations' }
  root 'home#index'
  resources :searchbar, only: :index
  resources :home, only: [:index, :new, :create]
  resources :user do
    resources :dashboard, only: [:index, :update]
    resources :avatars, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bookcopy do
    resources :borrow
  end
  resources :mailback, only: :new
end