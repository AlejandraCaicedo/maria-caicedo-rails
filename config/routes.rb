Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "articles#index"
  
  resources :relationships
  resources :users
  resources :articles do
    resources :comments
  end
  
end
