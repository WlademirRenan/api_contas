Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pessoa
      resources :transferencia do
        put '/estornar_transferencia' => 'transferencia#estornar_transferencia', on: :collection
      end
      resources :aporte do
        put '/estornar_aporte' => 'aporte#estornar_aporte', on: :collection
      end
      resources :conta do
        put '/:id/cancelar' => 'conta#cancelar', on: :collection
        put '/:id/bloquear' => 'conta#bloquear', on: :collection
        put '/:id/ativar' => 'conta#ativar', on: :collection
        get '/:id/historico_entradas' => 'conta#historico_entradas', on: :collection
        get '/:id/historico_saidas' => 'conta#historico_saidas', on: :collection
      end
    end
  end
end
