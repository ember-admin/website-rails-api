Rails.application.routes.draw do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :products do
          collection do
            get :autocomplete
          end
        end
        resources :users do
          collection do
            get :autocomplete
          end
        end
        resources :companies do
          collection do
            get :autocomplete
          end
        end
        resources :avatars
        resources :product_images
        resources :logos
      end
    end
  end
end
