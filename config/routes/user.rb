devise_for :users, controllers: {
  registrations: 'users/registrations'
}

resources :items, only: %i[show]

root to: 'items#index'
