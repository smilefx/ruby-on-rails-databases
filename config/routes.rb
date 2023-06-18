Rails.application.routes.draw do
  root 'courses#index'

  get '/search', to: 'courses#search'

  resources :courses do
    resources :events
  end
end