Rails.application.routes.draw do
  # Devise με OmniAuth
  devise_for :users, :controllers => {:registrations => "registrations"}, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Login route για απλή σύνδεση
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  resources :categories do
    resources :posts
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  # Άλλες διαδρομές
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  root to: 'pages#index'
end
