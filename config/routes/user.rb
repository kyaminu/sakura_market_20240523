devise_for :users

resources :items, only: %i[show]

root to: 'items#index'
