Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pessoa
      resources :conta do
        put '/:id/cancelar' => 'conta#cancelar', on: :collection
        put '/:id/bloquear' => 'conta#bloquear', on: :collection
        put '/:id/ativar' => 'conta#ativar', on: :collection
      end
    end
  end
end
