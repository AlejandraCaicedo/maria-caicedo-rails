Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root "articles#index"

  resources :articles do
    resources :comments
  end
end