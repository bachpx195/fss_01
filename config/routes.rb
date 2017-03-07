Rails.application.routes.draw do
  resources :recipes
  root "home#index"
end
