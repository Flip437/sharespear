Rails.application.routes.draw do

  devise_for :users, path: 'users', controllers: { registrations: 'users/registrations' }
  root 'home#index'
  resources :searchbar, only: :index
  resources :home, only: [:index]
  resources :user do
    resources :dashboard, only: [:index]
    resources :avatars, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bookcopy do
    resources :borrow
  end
end