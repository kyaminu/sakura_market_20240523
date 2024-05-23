devise_for :administrations, controllers: {
  sessions: 'administrations/sessions'
}

namespace :administrations do
  root to: 'items#index'
end
