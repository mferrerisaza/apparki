Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'tickets#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :vehicles, only: [:index, :show, :update]
  resources :tickets, except: [:delete]
  resources :parking_zones, only: [:index, :show]
  get '/report_data', to: 'tickets#report_data', as: 'report_data'
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'arqueo', to: 'tickets#arqueo', as: 'arqueo'
  get 'landing', to: 'parking_zones#landing', as: 'landing'

  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
