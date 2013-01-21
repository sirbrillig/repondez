Repondez::Application.routes.draw do
  if Rails.env == 'development'
    devise_for :users
  else
    devise_for :users, controllers: { registrations: "registrations" }
  end

  resources :invitations, :questions

  resources :guests do
    get "find", on: :collection
    post "find", on: :collection
    get "view", on: :member
  end

  match '/admin' => 'guests#index'

  root to: 'guests#find'

end
