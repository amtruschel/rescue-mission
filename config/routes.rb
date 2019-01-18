Rails.application.routes.draw do
  resources :users, only: [:show, :edit]

  resources :questions do
    resources :responses do
      post 'vote_for_answer', on: :member
    end
  end

  root 'questions#index'
end
