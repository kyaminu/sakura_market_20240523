devise_for :administrators, controllers: {
  sessions: 'administrators/sessions'
}

namespace :administrators do
  resources :administrators, only: %i[index new edit create update destroy]
  root to: 'items#index'
end
