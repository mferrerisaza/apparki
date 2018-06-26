Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'tickets#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :vehicles, only: [:new, :create, :index, :show]
  resources :tickets, except: [:delete]
  get "/report_data", to: "tickets#report_data", as: "report_data"
  get "dashboard", to: "pages#dashboard", as: "dashboard"
end
