Rails.application.routes.draw do
  resources :commentaries, except: [:index, :show, :new]
  resources :posts
  patch 'posts/:id/rated', to: 'posts#rated', as: :rated

  devise_for :users

  root to: 'posts#index'
end
