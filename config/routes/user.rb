devise_for :users, controllers: {
  registrations: 'users/registrations'
}

resources :items, only: %i[show]
resource :cart, only: %i[show]
resources :cart_items, only: %i[create update destroy]

root to: 'items#index'
