Repondez::Application.routes.draw do
  resources :invitations

  resources :guests do
    get "find", on: :collection
    post "find", on: :collection
    get "view", on: :member
    get "update", on: :member
  end

  root to: 'guests#find'

end
