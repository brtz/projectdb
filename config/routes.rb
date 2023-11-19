# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  devise_for :api_users, controllers: { sessions: "api_users/sessions" }

  resources :secrets, except: :show
  resources :environments, except: :show
  resources :projects, except: :show
  resources :api_users, except: :show
  resources :users, except: :show

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "projects/spec", to: "projects#spec"
  get "environments/spec", to: "environments#spec"
  get "secrets/spec", to: "secrets#spec"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "application#index"
end
