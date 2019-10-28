Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :api, constraints: { format: 'json' } do  
    namespace :v1 do  
      resources :user, only: [:create, :index]
      resources :auth, only: [:create, :update]
      resources :kitchen, only: [:create, :index]
    end  
  end  
end
