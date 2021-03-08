Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  concern :soft_deletable do
    member do
      post :discard
      post :undiscard
    end
  end

  namespace :api do
    namespace :v1 do
      jsonapi_resources :users, concerns: :soft_deletable do
        get :current, on: :collection
      end
  
      jsonapi_resources :groups, concerns: :soft_deletable

      jsonapi_resources :exercises, concerns: :soft_deletable
      jsonapi_resources :routines, concerns: :soft_deletable  
    end
  end

  get 'admin', to: 'admin/base#index'
  get 'admin/*path', to: 'admin/base#index'

  get '*path', to: 'admin/base#index'

  root to: 'admin/base#index'
end
