Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'tickets#index', as: :authenticated_root
    end
    unauthenticated do
      root 'pages#home', as: :unauthenticated_root
    end
  end
  resources :vehicles, only: [:index, :show, :update]
  resources :tickets, except: [:delete]
  get "/report_data", to: "tickets#report_data", as: "report_data"
  get "dashboard", to: "pages#dashboard", as: "dashboard"
  get "arqueo", to: "tickets#arqueo", as: "arqueo"

    # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
