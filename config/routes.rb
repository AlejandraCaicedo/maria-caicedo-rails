Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "articles#index"
  
  resources :relationships, only: [:destroy]
  
  resources :users do
    resources :relationships, only: [:create]
  end

  resources :articles do
    resources :comments
  end
  
end
