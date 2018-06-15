Rails.application.routes.draw do
  get 'tickets/index'

  get 'tickets/new'

  get 'tickets/edit'

  get 'vehicles/tickets'

  get 'vehicles/parking_zones'

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'pages#home', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  root to: 'pages#home'
  resources :vehicles, only: [:new, :create, :index, :show]
  resources :tickets, only: [:new, :show, :create, :index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
