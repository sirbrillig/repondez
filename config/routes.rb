Repondez::Application.routes.draw do
  if Rails.env == 'development'
    devise_for :users
  else
    # Sign-ups are disabled in production.
    devise_for :users, controllers: { registrations: "registrations" }
  end

  # POST to /tokens.json with email and password to get a token
  # DELETE to /tokens/[token] to log out.
  resources :tokens, only: [:create, :destroy]

  resources :questions

  scope '/admin' do
    resources :users
  end

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
