Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      jsonapi_resources :geometries do; end
      jsonapi_resources :indicators do; end
      jsonapi_resources :indicator_data do; end
      jsonapi_resources :layers do; end
      jsonapi_resources :categories do; end
      jsonapi_resources :widgets do; end

      resources :geometries, only: [:index] do
        get 'tiles/:z/:x/:y', to: 'geometries#tiles', on: :collection
      end
      resources :downloads, only: [:show]
    end
  end
end
