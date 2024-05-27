devise_for :administrators, controllers: {
  sessions: 'administrators/sessions'
}

namespace :administrators do
  resources :administrators, only: %i[index new edit create update destroy]
  resources :items, only: %i[new edit create update destroy] do
    member do
      put :move_lower
      put :move_higher
    end
  end

  root to: 'items#index'
end
