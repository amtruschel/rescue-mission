Rails.application.routes.draw do
  get 'auth/github', to: 'sessions#create', as: 'github_auth'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get,:post]
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  resources :users, only: [:show, :edit]

  resources :questions do
    resources :responses do
      post 'vote_for_answer', on: :member
      post 'vote_against_answer', on: :member
    end
  end

  root 'questions#index'
end
