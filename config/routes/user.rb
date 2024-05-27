resources :items, only: %i[show]

root to: 'items#index'
