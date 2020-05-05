Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'pages#home'
  resources :users
  resources :posts, only: [:new, :show, :create, :destroy]
end
