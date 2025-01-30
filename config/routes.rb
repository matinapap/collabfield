Rails.application.routes.draw do
  # Devise με OmniAuth
  devise_for :users, :controllers => {:registrations => "registrations"}, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Login route για απλή σύνδεση
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  # Άλλες διαδρομές
  resources :posts
  root to: 'pages#index'
end
