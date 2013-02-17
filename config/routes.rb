Repondez::Application.routes.draw do
  if Rails.env == 'development'
    devise_for :users
  else
    devise_for :users, controllers: { registrations: "registrations" }
  end

  resources :tokens, only: [:create, :destroy]

  resources :questions, :users

  resources :invitations do
    get "find", on: :collection
  end

  resources :guests do
    get "find", on: :collection
    post "find", on: :collection
  end

  match '/admin' => 'guests#index'

  root to: 'guests#find'

end
