Rails.application.routes.draw do
  resources :users, only: [:show, :edit]

  resources :questions do
    resources :responses, only: [:new, :create, :edit]
  end
  
  root 'questions#index'
end
