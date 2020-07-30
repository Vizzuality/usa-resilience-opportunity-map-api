Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      jsonapi_resources :geometries do; end
      jsonapi_resources :indicators do; end
      jsonapi_resources :layers do; end
      jsonapi_resources :categories do; end
    end
  end
end
