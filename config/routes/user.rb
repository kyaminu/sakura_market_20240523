devise_for :users, controllers: {
  registrations: 'users/registrations'
}

resources :items, only: %i[show]
namespace :users do
  resources :addresses, only: %i[index new edit create update destroy]
end

root to: 'items#index'
