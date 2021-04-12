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
      devise_for :users

      jsonapi_resources :users, concerns: :soft_deletable do
        jsonapi_relationships

        get :current, on: :collection
        post :start_supervision, on: :member
        post :stop_supervision, on: :member
      end
  
      jsonapi_resources :groups, concerns: :soft_deletable
      jsonapi_resources :routines, concerns: :soft_deletable  
      jsonapi_resources :exercises
      jsonapi_resources :routine_exercises
      jsonapi_resources :routine_intents
      jsonapi_resources :routine_intent_exercises
    end
  end

  get 'admin', to: 'admin/base#index'
  get 'admin/*path', to: 'admin/base#index'

  get '*path', to: 'admin/base#index'

  root to: 'admin/base#index'
end
