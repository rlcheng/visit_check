Rails.application.routes.draw do
  get "sign_up", to: "users#new"
  get "log_in", to: "sessions#new" 
  post "log_in", to: "sessions#create"
  get "log_out", to: "sessions#destroy"

  root :to => "users#new"

  resources :users do
    resources :visits
  end
  resources :sessions
  resources :apps
end
