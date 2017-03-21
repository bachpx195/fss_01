Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
    controllers: {omniauth_callbacks: "omniauth_callbacks#create"}

  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page", to: "pages#show"
    root "pages#show", page: "home"
    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: :show
    resources :recipes do
      resources :votes, except: [:index, :show, :destroy]
      resources :recipe_steps, controller: "recipe_steps"
      resources :collections, only: [:new, :create], controller: "collections"
    end
    resources :comments, except: [:index, :show, :new]

    resources :likes, only: [:create, :destroy]
    resources :searches, only: [:index]
    resources :collections, only: [:index, :show]

    namespace :admin do
      root "dashboard#home"
      resources :users, only: [:index, :update]
      resources :recipes, only: [:index, :update, :destroy]
      resources :category_groups do
        resources :categories
      end
    end

    namespace :personal do
      root "users#show"
      resources :users, only: [:show, :edit, :update]
      resources :recipes, only: [:index, :destroy]
      resources :collections
      resources :collections_recipes, only: [:destroy, :show, :update]
    end
  end
end
