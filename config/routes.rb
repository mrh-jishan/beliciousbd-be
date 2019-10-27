Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :api, constraints: { format: 'json' } do  
    namespace :v1 do  
      resources :user
      resources :auth
      get :confirm_email
    end  
  end  
end
