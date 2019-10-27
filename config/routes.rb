Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :api, constraints: { format: 'json' } do  
    namespace :v1 do  
      resources :user, only: [:create]
      resources :auth, only: [:create, :update]
    end  
  end  
end
