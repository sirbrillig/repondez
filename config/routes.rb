Repondez::Application.routes.draw do
  get "invitation/view"

  resources :guests do
    get "find", on: :collection
    get "view", on: :member
    get "update", on: :member
  end

  root to: 'guests#find'

end
