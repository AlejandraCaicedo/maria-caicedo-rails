Rails.application.routes.draw do
  devise_for :users

  root "articles#index"
  
  resources :users
  resources :articles do
    resources :comments
  end
  
end
