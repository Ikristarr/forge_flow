Rails.application.routes.draw do
  resources :workspaces, only: %i[index show new create]
  resource :registration, only: %i[new create]
  resource :session
  resources :passwords, param: :token
  root "home#index"
end