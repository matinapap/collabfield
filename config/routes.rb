Rails.application.routes.draw do
  # Devise με OmniAuth
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  # Login route για απλή σύνδεση
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  # Route για εγγραφή νέου χρήστη
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  # Κατηγορίες και δημοσιεύσεις
  resources :categories do
    resources :posts
  end

  # Δημοσιεύσεις με επιπλέον φίλτρα (hobby, study, team)
  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end

  # Αρχική σελίδα
  root to: 'pages#index'

  # Ιδιωτικές συνομιλίες και μηνύματα
  namespace :private do
    resources :conversations do
      member do
        delete 'close_conversation', to: 'conversations#close_conversation'
      end
    end
  end

  # Ιδιωτικές συνομιλίες εκτός namespace
  resources :private_conversations, only: [:index, :show, :create, :destroy]
end
