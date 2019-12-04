Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions" }
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bookcopy do
    resources :borrow
  end
end
