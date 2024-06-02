devise_for :users, controllers: {
  registrations: 'users/registrations'
}

resources :items, only: %i[show]
namespace :users do
  resources :addresses, only: %i[index new edit create update destroy]
end
resource :cart, only: %i[show]
resources :cart_items, only: %i[create update destroy]

root to: 'items#index'
