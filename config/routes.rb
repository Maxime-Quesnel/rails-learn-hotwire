Rails.application.routes.draw do
  devise_for :users


  resources :employees do
    member do
      patch :like, to: "employees#like"
    end
  end
  resources :messages, only: [:index, :create, :destroy]

  root to: 'employees#index'
end
