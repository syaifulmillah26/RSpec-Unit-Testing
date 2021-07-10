Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    post '/auth/signin', to: 'user_token#create'
    resources :posts
    resources :users do
      member do
        put :activate
        put :inactivate
      end
    end
  end
end
