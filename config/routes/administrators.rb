devise_for :administrators, controllers: {
  sessions: 'administrators/sessions'
}

namespace :administrators do
  resources :administrators, only: %i[index new edit create update destroy]
  resources :items, only: %i[new edit create update destroy move_higher move_lower]

  root to: 'items#index'
end
