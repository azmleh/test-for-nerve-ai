Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  mount ActionCable.server => '/cable'
  
  get '/', to: 'welcome#index', as: 'index'
  post '/registration', to: 'welcome#registration', as: 'registration'
  post '/confirm', to: 'welcome#confirm'
  get '/game', to: 'welcome#game', as: 'game'

  resources :matches, only: [:show, :create]
  resource :match
  
  namespace :api do
    resources :matches, only: [:show]
  end
  
end
