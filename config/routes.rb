WithingsImporter::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :weight_import, only: [:new, :create, :show]

  root "pages#home"
end
