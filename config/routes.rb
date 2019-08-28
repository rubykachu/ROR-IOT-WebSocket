Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'devices#index'
  get '/sign-in'     => 'sessions#new'
  post '/sign-in'    => 'sessions#create'
  delete '/sign-out' => 'sessions#destroy'

  resources :users
  resources :areas
  resources :devices
  resources :groups
end
