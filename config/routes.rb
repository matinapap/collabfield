Rails.application.routes.draw do
  devise_for :users
  resources :posts
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root to: 'pages#index'

  # Render dynamic PWA files if needed (uncomment if used)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
