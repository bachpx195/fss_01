Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
    controllers: {omniauth_callbacks: "omniauth_callbacks#create"}

  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page", to: "pages#show"
    root "pages#show", page: "home"
    resources :recipes

    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: :show
    resources :recipes, only: :show
    resources :likes, only: [:create, :destroy]

    namespace :admin do
      root "dashboard#home"
      resources :users
    end
  end
end
