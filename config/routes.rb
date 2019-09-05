Rails.application.routes.draw do
  resources :commentaries, except: [:index, :show, :new]
  resources :posts
  devise_for :users

  root to: 'posts#index'
end
