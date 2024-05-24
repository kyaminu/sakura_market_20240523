devise_for :administrators, controllers: {
  sessions: 'administrators/sessions'
}

namespace :administrators do
  root to: 'items#index'
end
