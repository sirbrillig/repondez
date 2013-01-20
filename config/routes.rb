Repondez::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  resources :invitations

  resources :guests do
    get "find", on: :collection
    post "find", on: :collection
    get "view", on: :member
  end

  root to: 'guests#find'

end
