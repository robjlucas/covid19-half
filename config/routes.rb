Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :pages, only: [:show], param: :page

  root to: "pages#show", page: "home"
end
