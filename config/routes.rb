Rails.application.routes.draw do
  root :to => 'application#index'
  
  namespace :api, constraints: { format: 'json' } do  
    namespace :v1 do  
      
      resources :user, only: [:create, :index]
      resources :auth, only: [:create, :update]
      
      resources :kitchen, only: [:create, :index] do
        resources :food, only: [:index, :create] # new, was removed, set if error found
      end

      resources :order_cart, only: [:index, :create]
      resources :order, only: [:index, :create, :update] do 
        resources :order_rating, only: [:create]
      end
    end  
  end  
end
