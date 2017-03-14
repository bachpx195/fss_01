Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
    controllers: {omniauth_callbacks: "omniauth_callbacks#create"}

  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page", to: "pages#show"
    root "pages#show", page: "home"
    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: :show
    resources :recipes
    resources :comments, except: [:index, :show, :new]
    resources :likes, only: [:create, :destroy]
    resources :searches, only: [:index]
    resources :collections, only: [:index, :show]

    namespace :admin do
      root "dashboard#home"
      resources :users, only: [:index, :update]
      resources :recipes, only: [:index, :update]
    end
  end
end
