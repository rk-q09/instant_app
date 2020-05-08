Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    authenticated :user do
      root :to => 'pages#home', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: [:new, :show, :create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
